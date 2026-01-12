# # Dev
# path "axonaio-kv-secrets/data/dev/*" {
#   capabilities = ["create", "read", "update", "list"]
# }

# path "axonaio-kv-secrets/metadata/dev/*" {
#   capabilities = ["list"]
# }

# Test
path "axonaio-kv-secrets/data/test/*" {
  capabilities = ["create", "read", "update", "list"]
}

path "axonaio-kv-secrets/metadata/test/*" {
  capabilities = ["list"]
}

# Prod (read-only)
path "axonaio-kv-secrets/data/production/*" {
  capabilities = ["read"]
}

path "axonaio-kv-secrets/metadata/production/*" {
  capabilities = ["list"]
}
