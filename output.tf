
# Outputs for AppRole Role IDs and Secret IDs
output "approle_role_ids" {
  description = "AppRole Role IDs for each environment"
  value = {
    for role_name, role_id in module.approle.approle_role_id :
    role_name => {
      role_id = role_id
    }
  }
}

# Outputs for AppRole Secret IDs
output "approle_secret_ids" {
  description = "AppRole Secret IDs for each environment"
  value = {
    for role_name, secret_id in module.approle.approle_secret_id :
    role_name => {
      secret_id = secret_id
    }
  }
  sensitive = true
}

# Separate outputs for easier access
output "gistore_test_role_id" {
  description = "Role ID for gistore-test"
  value       = module.approle.approle_role_id["gistore-test"]
}

output "gistore_test_secret_id" {
  description = "Secret ID for gistore-test"
  value       = module.approle.approle_secret_id["gistore-test"]
  sensitive   = true
}

output "gistore_production_role_id" {
  description = "Role ID for gistore-production"
  value       = module.approle.approle_role_id["gistore-production"]
}

output "gistore_production_secret_id" {
  description = "Secret ID for gistore-production"
  value       = module.approle.approle_secret_id["gistore-production"]
  sensitive   = true
}
