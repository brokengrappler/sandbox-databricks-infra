# modules/access-roles/finance_dev_read_only/main.tf

variable "principal_name" {
  description = "The name of the group to grant these permissions to."
  type        = string
}

# Grant usage on the catalog
resource "databricks_grant" "catalog_usage" {
  catalog    = "finance_dev_catalog"
  principal  = var.principal_name
  privileges = ["USE_CATALOG"]
}

# Grant usage on the gold schema
resource "databricks_grant" "schema_usage" {
  schema     = "finance_dev_catalog.gold_schema"
  principal  = var.principal_name
  privileges = ["USE_SCHEMA"]
}

# Grant SELECT on all tables in the gold schema
resource "databricks_grant" "table_select" {
  schema     = "finance_dev_catalog.gold_schema"
  principal  = var.principal_name
  privileges = ["SELECT"]
}
