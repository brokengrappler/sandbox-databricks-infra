module "catalog_dev" {
  source = "../../_modules/catalogs"

  catalog_name        = "${var.catalog_name}_DEV"
  catalog_description = "Catalog dev env"
}

module "catalog_dev" {
  source = "../../_modules/catalogs"

  catalog_name        = "${var.catalog_name}_DEV"
  catalog_description = "Catalog prod env"
}
