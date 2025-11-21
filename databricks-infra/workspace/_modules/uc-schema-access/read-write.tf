# Read-Write Schema Usage
resource "databricks_grant" "rw_schema_usage" {
  for_each   = local.rw_grants
  schema     = "${var.catalog_name_mapping[each.value.catalog]}.${each.value.schema}"
  principal  = each.value.role
  privileges = ["USE_SCHEMA"]
}

# Read-Write Table Modify
resource "databricks_grant" "rw_table_modify" {
  for_each   = local.rw_grants
  schema     = "${var.catalog_name_mapping[each.value.catalog]}.${each.value.schema}"
  principal  = each.value.role
  privileges = ["SELECT", "MODIFY", "CREATE_TABLE"]
}
