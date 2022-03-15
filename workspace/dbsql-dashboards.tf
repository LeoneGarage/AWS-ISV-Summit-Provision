resource "databricks_sql_dashboard" "d_ins_fraud" {
  name = "Insurance Fraud"
}

resource "databricks_sql_widget" "d1w1" {
  dashboard_id = databricks_sql_dashboard.d_ins_fraud.id
  visualization_id = databricks_sql_visualization.q_ins_fraud_hobbies_viz_fraud_pie.id
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
  dashboard_id = databricks_sql_dashboard.d_ins_fraud.id
  visualization_id = databricks_sql_visualization.q_ins_fraud_hobbies_viz_claim_amount.id
  title = "Chart - Insurance Fraud by hobbies"

  position {
    auto_height = false
    size_x = 3
    size_y = 12
    pos_x = 3
    pos_y = 0
  }
}

resource "databricks_sql_widget" "d1w3" {
  dashboard_id = databricks_sql_dashboard.d_ins_fraud.id
  visualization_id = databricks_sql_visualization.q_ins_fraud_hobbies_viz_weekend.id
  title = "Chart - Insurance Fraud by hobbies"

  position {
    auto_height = false
    size_x = 3
    size_y = 12
    pos_x = 0
    pos_y = 12
  }
}

resource "databricks_sql_widget" "d1w4" {
  dashboard_id = databricks_sql_dashboard.d_ins_fraud.id
  visualization_id = databricks_sql_visualization.q_ins_fraud_percent_viz_fraud.id
  title = "Chart - Insurance Fraud by hobbies"

  position {
    auto_height = false
    size_x = 3
    size_y = 12
    pos_x = 3
    pos_y = 24
  }
}

resource "databricks_sql_widget" "d1w5" {
  dashboard_id = databricks_sql_dashboard.d_ins_fraud.id
  visualization_id = databricks_sql_visualization.q_ins_fraud_by_severity_viz_pie.id
  title = "Chart - Insurance Fraud by hobbies"

  position {
    auto_height = false
    size_x = 3
    size_y = 12
    pos_x = 0
    pos_y = 24
  }
}

resource "databricks_sql_widget" "d1w6" {
  dashboard_id = databricks_sql_dashboard.d_ins_fraud.id
  visualization_id = databricks_sql_visualization.q_ins_fraud_by_severity_viz_severity_by_hobbies.id
  title = "Chart - Insurance Fraud by hobbies"

  position {
    auto_height = false
    size_x = 3
    size_y = 12
    pos_x = 3
    pos_y = 37
  }
}

resource "databricks_sql_widget" "d1w7" {
  dashboard_id = databricks_sql_dashboard.d_ins_fraud.id
  visualization_id = databricks_sql_visualization.q_ins_fraud_by_severity_viz_weekend_fraud.id
  title = "Chart - Insurance Fraud by hobbies"

  position {
    auto_height = false
    size_x = 3
    size_y = 12
    pos_x = 0
    pos_y = 37
  }
}

resource "databricks_sql_widget" "d1w8" {
  dashboard_id = databricks_sql_dashboard.d_ins_fraud.id
  visualization_id = databricks_sql_visualization.q_ins_fraud_fitted_viz_fraud_reported.id
  title = "Chart - Insurance Fraud by hobbies"

  position {
    auto_height = false
    size_x = 3
    size_y = 12
    pos_x = 0
    pos_y = 0
  }
}