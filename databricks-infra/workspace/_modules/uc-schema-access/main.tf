# Use for_each to loop over the lists of principals, creating a grant for each.
# This makes the module incredibly flexible.

# Read-Only Grants
resource "databricks_grant" "ro_catalog_usage" {
  for_each = toset(var.read_only_principals)
  catalog    = var.catalog_name
  principal  = each.key
  privileges = ["USE_CATALOG"]
}

resource "databricks_grant" "ro_schema_usage" {
  for_each = toset(var.read_only_principals)
  schema     = "${var.catalog_name}.${var.schema_name}"
  principal  = each.key
  privileges = ["USE_SCHEMA"]
}

resource "databricks_grant" "ro_table_select" {
  for_each = toset(var.read_only_principals)
  schema     = "${var.catalog_name}.${var.schema_name}"
  principal  = each.key
  privileges = ["SELECT"] # SELECT on ALL TABLES IN SCHEMA
}

# Read-Write Grants
resource "databricks_grant" "rw_catalog_usage" {
  for_each = toset(var.read_write_principals)
  catalog    = var.catalog_name
  principal  = each.key
  privileges = ["USE_CATALOG"]
}

resource "databricks_grant" "rw_schema_usage" {
  for_each = toset(var.read_write_principals)
  schema     = "${var.catalog_name}.${var.schema_name}"
  principal  = each.key
  privileges = ["USE_SCHEMA"]
}

resource "databricks_grant" "rw_table_modify" {
  for_each = toset(var.read_write_principals)
  schema     = "${var.catalog_name}.${var.schema_name}"
  principal  = each.key
  # Granting full read-write privileges
  privileges = ["SELECT", "MODIFY", "CREATE_TABLE"]
}
