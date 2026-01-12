# Retrieve Vault Identity Entities for all users in the group_members local variable
data "vault_identity_entity" "users" {
  for_each    = toset(flatten(values(local.group_members)))
  entity_name = each.value
}