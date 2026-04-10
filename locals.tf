locals {
  # Policies (definition

  policies = {
    # group policy
    gistore-developer = {
      file = "policies/gistore-developer.hcl"
    }

    # approle policy
    gistore-approle-test = {
      file = "policies/gistore-approle-test.hcl"
    }
    gistore-approle-production = {
      file = "policies/gistore-approle-production.hcl"
    }
  }

  # Groups (authorization

  groups = {
    # attach created policies to groups
    gistore-developer-group = {
      policies = ["gistore-developer"]
    }
  }

  # Group membership
  group_members = {
    gistore-developer-group = ["devendra"] #list the existing users here
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

  approles = {
    gistore-test = {
      token_policies = ["gistore-approle-test"]
      token_ttl      = 2700000
      token_max_ttl  = 32400000
    }
    gistore-production = {
      token_policies = ["gistore-approle-production"]
      token_ttl      = 2700000
      token_max_ttl  = 32400000
    }
  }
}
