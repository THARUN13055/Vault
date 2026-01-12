variable "approle_backend_path" {
  type = string
}

variable "approle_role_name" {
  type = string
}

variable "approle_token_policies" {
  type = list(string)
}