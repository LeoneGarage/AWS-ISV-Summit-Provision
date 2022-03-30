resource "databricks_sql_endpoint" "isv_summit" {
  name             = "isv_summit"
  cluster_size     = "Medium"
  max_num_clusters = 10
  auto_stop_mins = 30
  spot_instance_policy = "COST_OPTIMIZED"
}

resource "databricks_permissions" "isv_summit_endpoint_usage" {
  sql_endpoint_id = databricks_sql_endpoint.isv_summit.id

  access_control {
    group_name       = databricks_group.isv_summit.display_name
    permission_level = "CAN_USE"
  }
}