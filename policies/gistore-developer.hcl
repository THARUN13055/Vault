# Test
path "gistore-kv-secrets/data/test/*" {
  capabilities = ["create", "read", "update", "list"]
}

path "gistore-kv-secrets/metadata/*" {
  capabilities = ["list"]
}

# Prod (read-only)
path "gistore-kv-secrets/data/production/*" {
  capabilities = ["create", "read", "update", "list"]
}

path "gistore-kv-secrets/metadata/*" {
  capabilities = ["list"]
}
