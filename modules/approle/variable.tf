variable "approle_backend_path" {
  type = string
}

variable "approle" {
  description = "Approles per environments"
  type = map(object({
    token_policies = list(string)
    token_ttl      = number
    token_max_ttl  = number
  }))
}