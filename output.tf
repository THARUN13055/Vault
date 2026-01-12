output "approle_role_ids" {
  description = "AppRole Role IDs for each environment"
  value = {
    for role_name, role_id in module.approle.approle_role_id :
    role_name => {
      role_id = role_id
    }
  }
}

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
output "axonaio_test_role_id" {
  description = "Role ID for axonaio-test"
  value       = module.approle.approle_role_id["axonaio-test"]
}

output "axonaio_test_secret_id" {
  description = "Secret ID for axonaio-test"
  value       = module.approle.approle_secret_id["axonaio-test"]
  sensitive   = true
}

output "axonaio_production_role_id" {
  description = "Role ID for axonaio-production"
  value       = module.approle.approle_role_id["axonaio-production"]
}

output "axonaio_production_secret_id" {
  description = "Secret ID for axonaio-production"
  value       = module.approle.approle_secret_id["axonaio-production"]
  sensitive   = true
}