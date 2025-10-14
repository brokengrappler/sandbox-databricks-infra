module "data_mart" {
  source           = "../../../_modules/data_mart"
  catalog_name     = "FINANCE"
  public_schemas   = local.public_schema_list
  privileged_schemas = local.privileged_schema_list
  all_schemas = concat(local.public_schema_list, local.privileged_schema_list)

}
