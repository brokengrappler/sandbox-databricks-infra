# Catalog-level grants for roles with any access to the catalog
resource "databricks_grant" "catalog_usage" {
  for_each   = local.role_catalog_pairs
  catalog    = var.catalog_name_mapping[split(":", each.key)[1]]
  principal  = split(":", each.key)[0]
  privileges = ["USE_CATALOG"]
}

# Read-Only Schema Usage
resource "databricks_grant" "ro_schema_usage" {
  for_each   = local.ro_grants
  schema     = "${var.catalog_name_mapping[each.value.catalog]}.${each.value.schema}"
  principal  = each.value.role
  privileges = ["USE_SCHEMA"]
}

# Read-Only Table Select
resource "databricks_grant" "ro_table_select" {
  for_each   = local.ro_grants
  schema     = "${var.catalog_name_mapping[each.value.catalog]}.${each.value.schema}"
  principal  = each.value.role
  privileges = ["SELECT"]
}
