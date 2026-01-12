resource "vault_identity_group_member_entity_ids" "members_entities" {

  exclusive         = true
  member_entity_ids = var.member_entity_ids
  group_id          = var.group_id
}