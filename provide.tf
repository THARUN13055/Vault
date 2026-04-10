terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.20"
    }
  }
  cloud {
    organization = "axonaio"
    workspaces {
      name = "gistore"
    }
  }
}

provider "vault" {
  address = var.vault_addr
  token   = var.vault_token
}
