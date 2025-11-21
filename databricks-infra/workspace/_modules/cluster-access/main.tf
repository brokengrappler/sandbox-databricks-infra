# Use the databricks_permissions resource for non-UC objects

# Grant access to the cluster policy if an ID is provided
resource "databricks_permissions" "cluster_policy_usage" {
  # Only create this resource if cluster_policy_id is not null
  count = var.cluster_policy_id != null ? 1 : 0

  cluster_policy_id = var.cluster_policy_id
  access_control {
    group_name       = var.principal_name
    permission_level = "CAN_USE"
  }
}

# Grant access to the SQL warehouse if an ID is provided
resource "databricks_permissions" "sql_warehouse_usage" {
  count = var.sql_warehouse_id != null ? 1 : 0

  sql_warehouse_id = var.sql_warehouse_id
  access_control {
    group_name       = var.principal_name
    permission_level = "CAN_USE"
  }
}
