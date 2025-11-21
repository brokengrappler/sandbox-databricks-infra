module finance_data_mart {
    source = "./marts/finance/"
    public_schemas = local.public_schema_list
    privileged_schemas = local.privileged_schema_list
}

resource "databricks_group" "finance_analysts" { display_name = "finance-analysts" }
resource "databricks_group" "data_engineers" { display_name = "data-engineers" }

