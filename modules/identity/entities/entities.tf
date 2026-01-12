# Add members (entity IDs) to a Vault identity group
resource "vault_identity_group_member_entity_ids" "members_entities" {
  group_id          = var.group_id
  member_entity_ids = var.member_entity_ids
}