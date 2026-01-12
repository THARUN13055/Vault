module "policy" {
  source = "./modules/policy"

  for_each = local.policies

  policy_name = each.key
  policy_file = "${path.module}/${each.value.file}"
}

# module "groups" {
#   source = "./modules/identity/groups"

#   for_each = local.groups

#   group_name         = each.key
#   add_group_policies = each.value.policies

#   depends_on = [module.policy]
# }

# module "kv" {
#   source             = "./modules/kv"
#   mount_path         = "axonai-kv-secret"
#   description        = "KV Version 2 secret engine mount"
#   secrets = local.kv_secrets
# }
