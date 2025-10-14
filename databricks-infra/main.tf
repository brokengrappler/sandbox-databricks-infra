module finance_data_mart {
    source = "./marts/finance/"
    public_schemas = local.public_schema_list
    privileged_schemas = local.privileged_schema_list
}
