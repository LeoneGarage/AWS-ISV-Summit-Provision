resource "databricks_sql_dashboard" "d_ins_fraud" {
  for_each = { for u in local.all_users: u.user_name => u }
  name = "${each.value.user_name} Insurance Fraud"
}

resource "databricks_permissions" "d_ins_fraud_permission" {
  for_each = { for k, d in databricks_sql_dashboard.d_ins_fraud: k => d if k != data.databricks_current_user.me.user_name }
  sql_dashboard_id = each.value.id

  // You can only specify "CAN_EDIT" permissions if the query `run_as_role` equals `viewer`.
  access_control {
    user_name       = each.key
    permission_level = "CAN_RUN"
  }
}

resource "databricks_sql_widget" "d1w1" {
  for_each = local.all_users
  dashboard_id = databricks_sql_dashboard.d_ins_fraud[each.value.user_name].id
  visualization_id = databricks_sql_visualization.q_ins_fraud_hobbies_viz_fraud_pie[each.value.user_name].id
  title = "Chart - Insurance Fraud by hobbies"

  position {
    auto_height = false
    size_x = 3
    size_y = 12
    pos_x = 3
    pos_y = 12
  }
}

resource "databricks_sql_widget" "d1w2" {
  for_each = local.all_users
  dashboard_id = databricks_sql_dashboard.d_ins_fraud[each.value.user_name].id
  visualization_id = databricks_sql_visualization.q_ins_fraud_hobbies_viz_claim_amount[each.value.user_name].id
  title = "Chart - Insurance Fraud amounts by hobbies"

  position {
    auto_height = false
    size_x = 3
    size_y = 12
    pos_x = 3
    pos_y = 0
  }
}

resource "databricks_sql_widget" "d1w3" {
  for_each = local.all_users
  dashboard_id = databricks_sql_dashboard.d_ins_fraud[each.value.user_name].id
  visualization_id = databricks_sql_visualization.q_ins_fraud_hobbies_viz_weekend[each.value.user_name].id
  title = "Chart - Insurance Fraud on weekends by hobbies"

  position {
    auto_height = false
    size_x = 3
    size_y = 12
    pos_x = 0
    pos_y = 12
  }
}

resource "databricks_sql_widget" "d1w4" {
  for_each = local.all_users
  dashboard_id = databricks_sql_dashboard.d_ins_fraud[each.value.user_name].id
  visualization_id = databricks_sql_visualization.q_ins_fraud_percent_viz_fraud[each.value.user_name].id
  title = "Chart - Insurance Fraud percentage"

  position {
    auto_height = false
    size_x = 3
    size_y = 12
    pos_x = 3
    pos_y = 24
  }
}

resource "databricks_sql_widget" "d1w5" {
  for_each = local.all_users
  dashboard_id = databricks_sql_dashboard.d_ins_fraud[each.value.user_name].id
  visualization_id = databricks_sql_visualization.q_ins_fraud_by_severity_viz_pie[each.value.user_name].id
  title = "Chart - Insurance Fraud by incident severity"

  position {
    auto_height = false
    size_x = 3
    size_y = 12
    pos_x = 0
    pos_y = 24
  }
}

resource "databricks_sql_widget" "d1w6" {
  for_each = local.all_users
  dashboard_id = databricks_sql_dashboard.d_ins_fraud[each.value.user_name].id
  visualization_id = databricks_sql_visualization.q_ins_fraud_by_severity_viz_severity_by_hobbies[each.value.user_name].id
  title = "Chart - Insurance Fraud by incident severity for hobbies"

  position {
    auto_height = false
    size_x = 3
    size_y = 12
    pos_x = 3
    pos_y = 37
  }
}

resource "databricks_sql_widget" "d1w7" {
  for_each = local.all_users
  dashboard_id = databricks_sql_dashboard.d_ins_fraud[each.value.user_name].id
  visualization_id = databricks_sql_visualization.q_ins_fraud_by_severity_viz_weekend_fraud[each.value.user_name].id
  title = "Chart - Insurance Fraud weekend fraud vs valid by hobbies"

  position {
    auto_height = false
    size_x = 3
    size_y = 12
    pos_x = 0
    pos_y = 37
  }
}

resource "databricks_sql_widget" "d1w8" {
  for_each = local.all_users
  dashboard_id = databricks_sql_dashboard.d_ins_fraud[each.value.user_name].id
  visualization_id = databricks_sql_visualization.q_ins_fraud_fitted_viz_fraud_reported[each.value.user_name].id
  title = "Chart - Insurance Fraud of training data"

  position {
    auto_height = false
    size_x = 3
    size_y = 12
    pos_x = 0
    pos_y = 0
  }
}
