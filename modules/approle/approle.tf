resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_approle_auth_backend_role" "approle_role" {
  backend        = var.approle_backend_path
  role_name      = var.approle_role_name
  token_policies = var.approle_token_policies
}