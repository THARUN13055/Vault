variable "vault_addr" {
  type    = string
  default = "https://vault.nexagames.in"
}

variable "vault_token" {
  type      = string
  sensitive = true
}
