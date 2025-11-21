resource "databricks_cluster_policy" "fair_use" {
  name       = "${var.team} cluster policy"
  definition = jsonencode(merge(local.default_policy, var.policy_overrides))

  libraries {
    pypi {
      package = "databricks-sdk==0.12.0"
      // repo can also be specified here
    }
  }
  libraries {
    maven {
      coordinates = "com.oracle.database.jdbc:ojdbc8:XXXX"
    }
  }
}

resource "databricks_permissions" "can_use_cluster_policyinstance_profile" {
  cluster_policy_id = databricks_cluster_policy.fair_use.id
  access_control {
    group_name       = var.team
    permission_level = "CAN_USE"
  }
}
