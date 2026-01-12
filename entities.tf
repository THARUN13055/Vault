# data "vault_identity_entity" "users" {
#   for_each    = toset(flatten(values(local.group_members)))
#   entity_name = each.value
# }


# resource "vault_identity_group_member_entity_ids" "memberships" {
#   for_each = local.group_members

#   group_id = module.groups[each.key].group_id

#   member_entity_ids = [
#     for user in each.value :
#     data.vault_identity_entity.users[user].id
#   ]
# }