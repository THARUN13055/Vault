# Vault Production Setup

## Knowledge Requirements

1. HashiCorp Vault
2. Terraform
3. Vault workflows
4. Basic security concepts

## Problems This Project Solves

- Securely manage secrets for different environments (test, production)
- Implement role-based access control using AppRoles
- Organize Vault resources in a clear and maintainable structure
- Automate the provisioning of Vault resources using Terraform
- Ensure separation of concerns between different environments and human users
- Maintain a clear mapping between Vault policies, AppRoles, and their associated entities

## Architecture

```
Project: axonaio
│
├── KV (secrets engine)
│   └── axonaio-kv-secrets/
│       ├── test/
│       │   ├── frontend
│       │   └── backend
│       └── production/
│           ├── frontend
│           └── backend
│
├── Policies
│   ├── axonaio-developer (for human users)
│   ├── axonaio-approle-test
│   └── axonaio-approle-production
│
├── AppRole auth mount
│   └── auth/axonaio/
│
├── AppRoles
│   ├── axonaio-test
│   │   ├── policy: axonaio-approle-test
│   │   ├── role_id
│   │   └── secret_ids
│   │
│   └── axonaio-production
│       ├── policy: axonaio-approle-production
│       ├── role_id
│       └── secret_ids
│
└── Humans (separate, already managed)
    └── groups → policies → entities
```

## Key Components Explained

### Policy
We created policies for both groups (human users) and AppRoles (applications). This provides fine-grained access control for different types of users.

### Groups
Groups play a major role in this setup. We assign policies to groups instead of individual users. This approach offers several benefits:
- Easy user management - add/remove users without policy changes
- No data loss when deleting entities
- Simplified permission management
- Better scalability

### Entities
We work with existing entities in Vault rather than creating new ones. This approach:
- Simplifies the project structure
- Avoids complexity in entity creation
- Leverages existing user management
- Note: If you need to create new entities, I can create a separate branch for that functionality

### KV (Key-Value) Secrets Engine
We use KV v2 to store secrets in a structured manner:
```
axonaio-kv-secrets/
├── test/
│   ├── frontend
│   └── backend
└── production/
    ├── frontend
    └── backend
```

**Access model:**
- Human developers (via groups): Can access KV secrets based on their group policies
- AppRoles: Have limited, environment-specific access

### AppRole
AppRoles provide machine/application authentication with limited permissions:
- **axonaio-test**: Read-only access to test environment secrets
- **axonaio-production**: Read-only access to production environment secrets

## Quick Start

### Prerequisites
- Terraform installed
- Vault server running and accessible
- Valid Vault token with appropriate permissions

### Setup Commands

```bash
# 1. Initialize Terraform
terraform init

# 2. Validate configuration
terraform validate

# 3. Format code (optional but recommended)
terraform fmt --recursive

# 4. Review execution plan
terraform plan

# 5. Apply configuration
terraform apply --auto-approve

# 6. Retrieve AppRole credentials
terraform output -json approle_secret_ids | jq

# 7. Get specific outputs
terraform output axonaio_test_role_id
terraform output axonaio_production_role_id
```

## Security Best Practices

### ⚠️ IMPORTANT: Never Commit Sensitive Files

Add these to your `.gitignore`:
```
# Terraform
*.tfstate
*.tfstate.*
*.tfvars
.terraform/
crash.log
override.tf
override.tf.json
```

### Use Environment Variables for Credentials

Instead of storing credentials in files:
```bash
export VAULT_ADDR="https://vault.nexagames.in"
export VAULT_TOKEN="your-vault-token-here"
```

## Configuration

### Adding New Users to a Group

Edit `locals.tf`:
```hcl
group_members = {
  axonaio-developer-group = ["tharun", "newuser"]  # Add username here
}
```

### Adding New Secrets

Edit `locals.tf`:
```hcl
kv_secrets = {
  "test/new-service" = {
    data = { key = "value" }
  }
}
```

### Creating New Policies

1. Create a `.hcl` file in the `policies/` directory
2. Add reference in `locals.tf`:
```hcl
policies = {
  your-new-policy = {
    file = "policies/your-new-policy.hcl"
  }
}
```

## Useful Commands

### Terraform
```bash
terraform init              # Initialize working directory
terraform validate          # Validate configuration syntax
terraform fmt --recursive   # Format all .tf files
terraform plan              # Preview changes
terraform apply             # Apply changes
terraform destroy           # Remove all resources (use with caution!)
terraform output            # Show all outputs
terraform state list        # List resources in state
```

### Vault CLI
```bash
# Check connection
vault status

# Read a secret
vault kv get axonaio-kv-secrets/test/backend

# List secrets
vault kv list axonaio-kv-secrets/test

# AppRole login (for testing)
vault write auth/axonaio/login \
  role_id="<role_id>" \
  secret_id="<secret_id>"

# Rotate AppRole secret
vault write -f auth/axonaio/role/axonaio-production/secret-id
```

## Troubleshooting

### Permission Denied
Verify your Vault token has necessary permissions:
```bash
vault token lookup
vault token capabilities <path>
```

### Entity Not Found
Ensure the entity exists in Vault before adding to groups:
```bash
vault list identity/entity/name
```

### AppRole Can't Access Secret
Verify policy paths match exactly:
```bash
vault policy read <policy-name>
vault read auth/axonaio/role/<role-name>
```

## Project Structure

```
.
├── README.md              # This file
├── main.tf                # Main configuration
├── provider.tf            # Vault provider setup
├── variables.tf           # Variable definitions
├── terraform.tfvars       # Variable values (DO NOT COMMIT)
├── locals.tf              # Local values and configuration
├── data.tf                # Data sources
├── output.tf              # Output definitions
├── entities.tf            # Entity configuration (commented)
│
├── modules/
│   ├── policy/            # Policy management
│   ├── identity/
│   │   ├── groups/        # Group management
│   │   └── entities/      # Entity membership
│   ├── kv/                # KV secrets engine
│   └── approle/           # AppRole authentication
│
└── policies/              # HCL policy files
    ├── axonaio-developer.hcl
    ├── axonaio-approle-test.hcl
    └── axonaio-approle-production.hcl
```

## Access Control Summary

### Human Users (Developers)
- **Group**: axonaio-developer-group
- **Policy**: axonaio-developer
- **Test Environment**: Full access (create, read, update, list)
- **Production Environment**: Read-only access

### Applications (AppRoles)
- **axonaio-test AppRole**
  - Policy: axonaio-approle-test
  - Access: Read-only to test secrets
  
- **axonaio-production AppRole**
  - Policy: axonaio-approle-production
  - Access: Read-only to production secrets

## Token Configuration
- **TTL**: 2,700,000 ms (~45 minutes)
- **Max TTL**: 32,400,000 ms (~9 hours)

## Support

If you have any doubts or ideas, please raise an issue in the GitHub repository. I will definitely resolve them!

## Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## Additional Resources

- [HashiCorp Vault Documentation](https://www.vaultproject.io/docs)
- [Terraform Vault Provider](https://registry.terraform.io/providers/hashicorp/vault/latest/docs)
- [Vault Best Practices](https://learn.hashicorp.com/tutorials/vault/production-hardening)

---

**Note**: This is a production setup. Always review and test changes in a non-production environment first.