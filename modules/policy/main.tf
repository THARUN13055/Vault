# Create a Vault policy using the provided name and policy file
resource "vault_policy" "policy" {
  name   = var.policy_name
  policy = file(var.policy_file)
}