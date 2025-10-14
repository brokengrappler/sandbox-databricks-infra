module "catalog_dev" {
  source = "../catalogs"

  catalog_name        = "${var.catalog_name}_DEV"
  catalog_description = "Catalog dev env"
}

module "catalog_prod" {
  source = "../catalogs"

  catalog_name        = "${var.catalog_name}_PROD"
  catalog_description = "Catalog prod env"
}
