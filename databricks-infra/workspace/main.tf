data "databricks_catalogs" "all" {}

locals {
    default_catalog = [for each in data.databricks_catalogs.all.ids : each if strcontains(each, var.sandbox_workspace)]
}

module finance_data_mart {
    source = "./marts/finance/"
    public_schemas = local.public_schema_list
    privileged_schemas = local.privileged_schema_list
}
