# Read secret values
path "axonaio-kv-secrets/data/test/*" {
  capabilities = ["read"]
}

# Allow listing metadata (required by SDKs)
path "axonaio-kv-secrets/metadata/test/*" {
  capabilities = ["list"]
}
