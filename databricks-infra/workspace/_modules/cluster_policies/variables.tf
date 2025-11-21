variable "team" {
  description = "Team that performs the work"
}

variable "policy_overrides" {
  description = "Cluster policy overrides"
}

locals {
  default_policy = {
    "dbus_per_hour" : {
      "type" : "range",
      "maxValue" : 10
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 20,
      "hidden" : true
    },
    "custom_tags.Team" : {
      "type" : "fixed",
      "value" : var.team
    }
  }
}
