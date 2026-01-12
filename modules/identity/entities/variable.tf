variable "member_entity_ids" {
  description = "List of entity IDs to add to the group"
  type        = list(string)
}

variable "group_id" {
  description = "The ID of the group"
  type        = string
}

variable "entity_names" {
  description = "List of entity names (for reference/documentation)"
  type        = list(string)
}
