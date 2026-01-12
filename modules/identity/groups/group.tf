resource "vault_identity_group" "group" {
  name     = var.group_name
  type     = "internal"
  policies = var.add_group_policies

  metadata = {
    version = "2"
  }
}