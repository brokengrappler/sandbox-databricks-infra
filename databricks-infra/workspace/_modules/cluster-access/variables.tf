variable "principal_name" {
  type        = string
  description = "The group name to grant compute access to."
}

variable "cluster_policy_id" {
  type        = string
  description = "The ID of the cluster policy to grant CAN_USE on."
  default     = null # Make it optional
}

variable "sql_warehouse_id" {
  type        = string
  description = "The ID of the SQL Warehouse to grant CAN_USE on."
  default     = null
}
