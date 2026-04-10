# Read secret values
path "gistore-kv-secrets/data/test/*" {
  capabilities = ["read"]
}

# Allow listing metadata (required by SDKs)
path "gistore-kv-secrets/metadata/test/*" {
  capabilities = ["list"]
}
