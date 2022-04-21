resource "databricks_sql_dashboard" "d_ins_claims" {
  for_each = { for u in local.all_users: u.user_name => u }
  name = "${each.value.user_name} Insurance Claims"
}

resource "databricks_permissions" "d_ins_claims_permission" {
  for_each = { for k, d in databricks_sql_dashboard.d_ins_claims: k => d if k != data.databricks_current_user.me.user_name }
  sql_dashboard_id = each.value.id

  // You can only specify "CAN_EDIT" permissions if the query `run_as_role` equals `viewer`.
  access_control {
    user_name       = each.key
    permission_level = "CAN_RUN"
  }
}

resource "databricks_sql_widget" "d_ins_claims_w_q_ins_claims_by_city_viz_pie" {
  for_each = local.all_users
  dashboard_id = databricks_sql_dashboard.d_ins_claims[each.value.user_name].id
  visualization_id = databricks_sql_visualization.q_ins_claims_by_city_viz_pie[each.value.user_name].id
  title = "Chart - Insurance Claim Amount Ratios by city"

  position {
    auto_height = false
    size_x = 3
    size_y = 8
    pos_x = 0
    pos_y = 0
  }
}

resource "databricks_sql_widget" "d_ins_claims_w_q_ins_claims_by_hobbies_viz_pie" {
  for_each = local.all_users
  dashboard_id = databricks_sql_dashboard.d_ins_claims[each.value.user_name].id
  visualization_id = databricks_sql_visualization.q_ins_claims_by_hobbies_viz_pie[each.value.user_name].id
  title = "Chart - Insurance Claim Amount Ratios by hobbies"

  position {
    auto_height = false
    size_x = 3
    size_y = 8
    pos_x = 3
    pos_y = 0
  }
}

resource "databricks_sql_widget" "d_ins_claims_w_q_ins_claims_by_auto_type_viz_pie" {
  for_each = local.all_users
  dashboard_id = databricks_sql_dashboard.d_ins_claims[each.value.user_name].id
  visualization_id = databricks_sql_visualization.q_ins_claims_by_auto_type_viz_pie[each.value.user_name].id
  title = "Chart - Insurance Claim Amount Ratios by Auto type"

  position {
    auto_height = false
    size_x = 6
    size_y = 13
    pos_x = 0
    pos_y = 8
  }
}
