# ============================
# Axonaio project - Developer
# ============================

# Full access to dev environment
path "kv/data/axonaio/dev/*" {
  capabilities = ["create", "read", "update", "list"]
}

path "kv/metadata/axonaio/dev/*" {
  capabilities = ["list"]
}

# Full access to test environment
path "kv/data/axonaio/test/*" {
  capabilities = ["create", "read", "update", "list"]
}

path "kv/metadata/axonaio/test/*" {
  capabilities = ["list"]
}

# Read-only access to production
path "kv/data/axonaio/prod/*" {
  capabilities = ["read"]
}

path "kv/metadata/axonaio/prod/*" {
  capabilities = ["list"]
}

# Read-only shared secrets
path "kv/data/axonaio/shared/*" {
  capabilities = ["read"]
}

path "kv/metadata/axonaio/shared/*" {
  capabilities = ["list"]
}
