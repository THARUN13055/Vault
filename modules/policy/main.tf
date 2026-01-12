resource "vault_policy" "policy" {
  name   = var.policy_name
  policy = file(var.policy_file)
}