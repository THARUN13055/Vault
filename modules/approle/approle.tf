# AppRole Authentication Backend Configuration
resource "vault_auth_backend" "approle" {
  type = "approle"
  path = var.approle_backend_path
}

# AppRole Roles Creation
resource "vault_approle_auth_backend_role" "approle_role" {
  for_each = var.approle

  backend        = vault_auth_backend.approle.path
  role_name      = each.key
  token_policies = each.value.token_policies
  token_ttl      = each.value.token_ttl
  token_max_ttl  = each.value.token_max_ttl
  depends_on     = [vault_auth_backend.approle]
}

# AppRole Secret IDs Creation
resource "vault_approle_auth_backend_role_secret_id" "approle_secret_id" {
  for_each = var.approle

  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.approle_role[each.key].role_name
}