resource "databricks_catalog" "catalog" {
  name    = var.catalog_name
  comment = var.catalog_description
  properties = {
    purpose = "POC"
  }
}
