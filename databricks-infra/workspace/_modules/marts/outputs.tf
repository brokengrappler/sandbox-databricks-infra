output "catalog_name_mapping" {
  description = "Map of logical to actual catalog names"
  value = {
    finance_dev  = module.catalog_dev.catalog_name
    finance_prod = module.catalog_prod.catalog_name
  }
}
