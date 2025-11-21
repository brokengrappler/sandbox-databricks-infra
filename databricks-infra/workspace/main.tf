module finance_data_mart {
    source = "./marts/finance/"
    public_schemas = local.public_schema_list
    privileged_schemas = local.privileged_schema_list
}

####### AI Recommended build that depends on the ./_modules/cluster-access and ./_modules/uc-schema-access modules

# main.tf

# First, define the groups and compute resources
resource "databricks_group" "finance_analysts" { display_name = "finance-analysts" }
resource "databricks_group" "data_engineers" { display_name = "data-engineers" }

