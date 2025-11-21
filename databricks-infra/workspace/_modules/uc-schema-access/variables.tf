variable "catalog_name" {
  type        = string
  description = "The name of the catalog."
}

variable "schema_name" {
  type        = string
  description = "The name of the schema."
}

variable "read_only_principals" {
  type        = list(string)
  description = "A list of group names to grant read-only access."
  default     = [] # Default to an empty list
}

variable "read_write_principals" {
  type        = list(string)
  description = "A list of group names to grant read-write access."
  default     = []
}
