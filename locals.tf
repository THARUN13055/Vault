locals {
  # Policies (definition

  policies = {
    # group policy
    axonaio-developer = {
      file = "policies/axonaio-developer.hcl"
    }

    # approle policy
    axonaio-approle-test = {
      file = "policies/axonaio-approle-test.hcl"
    }
    axonaio-approle-production = {
      file = "policies/axonaio-approle-production.hcl"
    }
  }

  # Groups (authorization

  groups = {
    # attach created policies to groups
    axonaio-developer-group = {
      policies = ["axonaio-developer"]
    }
  }

  # Group membership
  group_members = {
    axonaio-developer-group = ["tharun"] # list the existing users here
  }

  # KV Secrets to be created
  kv_secrets = {
    "test/frontend" = {
      data = { test = "frontend" }
    }
    "test/backend" = {
      data = { test = "backend" }
    }
    "production/frontend" = {
      data = { production = "frontend" }
    }
    "production/backend" = {
      data = { production = "backend" }
    }
  }
}
