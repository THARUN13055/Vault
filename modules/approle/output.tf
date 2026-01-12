output "approle_role_id" {
  value = {
    for k, v in vault_approle_auth_backend_role.approle_role : k => v.role_id
  }
}

output "approle_secret_id" {
  value = {
    for k, s in vault_approle_auth_backend_role_secret_id.approle_secret_id : k => s.secret_id
  }
  sensitive = true
}