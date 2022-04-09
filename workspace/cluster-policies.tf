resource "databricks_cluster_policy" "isv_summit" {
  name       = "ISV Summit Jobs cluster policy"
  definition = jsonencode({
    "cluster_type": {
        "type": "fixed",
        "value": "job"
    },
    "dbus_per_hour": {
        "type": "range",
        "maxValue": 100
    },
    "autoscale.min_workers": {
        "type": "range",
        "minValue": 1,
        "defaultValue": 2,
        "hidden": false
    },
    "autoscale.max_workers": {
        "type": "range",
        "maxValue": 10,
        "defaultValue": 10,
        "hidden": false
    }
    })
}

resource "databricks_permissions" "isv_summit_policy_permission" {
  cluster_policy_id = databricks_cluster_policy.isv_summit.id

  access_control {
    group_name       = databricks_group.isv_summit.display_name
    permission_level = "CAN_USE"
  }
}

resource "databricks_cluster_policy" "isv_summit_dlt" {
  name       = "ISV Summit DLT cluster policy"
  definition = jsonencode({
    "cluster_type": {
        "type": "fixed",
        "value": "dlt"
    }
    })
}

resource "databricks_permissions" "isv_summit_dlt_policy_permission" {
  cluster_policy_id = databricks_cluster_policy.isv_summit_dlt.id

  access_control {
    group_name       = databricks_group.isv_summit.display_name
    permission_level = "CAN_USE"
  }
}