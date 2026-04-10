# Create a KV secrets engine mount and store secrets in Vault
resource "vault_mount" "mount_path" {
  path        = var.mount_path
  type        = "kv"
  options     = { version = "2" }
  description = var.description
}

# Store secrets in the KV secrets engine
resource "vault_kv_secret_v2" "vault_secrets" {
  for_each = var.secrets

  mount               = var.mount_path
  name                = each.key
  cas                 = 1
  delete_all_versions = true
  data_json           = jsonencode(each.value.data)
  custom_metadata {
    max_versions = 20
  }
  depends_on = [vault_mount.mount_path]
}

