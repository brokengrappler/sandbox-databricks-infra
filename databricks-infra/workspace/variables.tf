variable "workspace_host" {
  type        = string
  description = "Databricks workspace URL (e.g., https://your-workspace.cloud.databricks.com)"
}

variable "client_id" {
  type        = string
  description = "Databricks service principal client ID (OAuth)"
  sensitive   = true
}

variable "client_secret" {
  type        = string
  description = "Databricks service principal client secret (OAuth)"
  sensitive   = true
}
