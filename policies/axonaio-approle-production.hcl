# Read secret values
path "axonaio-kv-secrets/data/production/*" {
  capabilities = ["read"]
}

# Allow listing metadata
path "axonaio-kv-secrets/metadata/production/*" {
  capabilities = ["list"]
}
