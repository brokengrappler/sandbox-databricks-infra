locals {
  access_config = yamldecode(file("${path.module}/access_config.yaml"))
}

module "finance_public_mart" {
  source              = "../../_modules/marts"
  catalog_name        = "finance_public"
  catalog_description = "Data mart for general analysts"
}

module "finance_restricted_mart" {
  source              = "../../_modules/marts"
  catalog_name        = "finance_restricted"
  catalog_description = "Data mart for Privileged Finance Users"
}

module "finance_public_uc_access" {
  source               = "../../_modules/uc-schema-access"
  catalog_name_mapping = module.finance_public_mart.catalog_name_mapping
  role_config          = local.access_config.roles
}
