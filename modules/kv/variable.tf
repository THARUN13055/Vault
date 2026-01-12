variable "mount_path" {
  type = string
}

variable "description" {
  type = string
}

variable "secrets" {
  type = map(object({
    data = map(string)
    }
  ))
}