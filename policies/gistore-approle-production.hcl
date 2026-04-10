# Read secret values
path "gistore-kv-secrets/data/production/*" {
  capabilities = ["read"]
}

# Allow listing metadata
path "gistore-kv-secrets/metadata/production/*" {
  capabilities = ["list"]
}
