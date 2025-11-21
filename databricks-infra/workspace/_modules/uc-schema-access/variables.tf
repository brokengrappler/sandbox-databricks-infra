locals {
  # Flatten the role_config into a map of "role:catalog:schema" => {role, catalog, schema, privilege}
  role_catalog_schema_map = merge(flatten([
    for role, role_config in var.role_config : [
      for catalog, catalog_config in role_config.catalogs : {
        for schema in catalog_config.schemas :
        "${role}:${catalog}:${schema}" => {
          role      = role
          catalog   = catalog
          schema    = schema
          privilege = catalog_config.privilege
        }
      }
    ]
  ])...)

  # Separate into RO and RW for easier filtering
  ro_grants = { for k, v in local.role_catalog_schema_map : k => v if v.privilege == "RO" }
  rw_grants = { for k, v in local.role_catalog_schema_map : k => v if v.privilege == "RW" }

  # Get unique role:catalog combinations for catalog-level grants
  role_catalog_pairs = toset(flatten([
    for role, role_config in var.role_config : [
      for catalog, catalog_config in role_config.catalogs :
      "${role}:${catalog}"
    ]
  ]))
}

variable "catalog_name_mapping" {
  type        = map(string)
  description = "Catalogs included in the mart"
}

variable "role_config" {
  type = map(object({
    catalogs = map(object({
      privilege = string
      schemas   = list(string)
    }))
  }))
  description = "Map of role names to their catalog access configurations"
  default     = {}
}
