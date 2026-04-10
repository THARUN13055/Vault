# Create Policy to attach Group and approle
module "policy" {
  source = "./modules/policy"

  for_each = local.policies

  policy_name = each.key
  policy_file = "${path.module}/${each.value.file}"
}

# Creating Group 
module "groups" {
  source = "./modules/identity/groups"

  for_each = local.groups

  group_name         = each.key
  add_group_policies = each.value.policies

  depends_on = [module.policy]
}

# Adding the existing users to the add in groups
module "group_entities" {
  source = "./modules/identity/entities"

  for_each = local.group_members

  entity_names      = each.value
  member_entity_ids = [for user in each.value : data.vault_identity_entity.users[user].id]
  group_id          = module.groups[each.key].group_id

  depends_on = [module.groups, data.vault_identity_entity.users]
}

# Create KV secret engine and add secrets
module "kv" {
  source      = "./modules/kv"
  mount_path  = "gistore-kv-secrets"
  description = "KV Version 2 secret engine mount"
  secrets     = local.kv_secrets
}

# Create AppRole auth method and add approles
module "approle" {
  source               = "./modules/approle"
  approle_backend_path = "gistore"
  approle              = local.approles
  depends_on           = [module.policy]
}
