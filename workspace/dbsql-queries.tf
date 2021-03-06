data "databricks_group" "admins" {
  display_name = "admins"
}

resource "databricks_sql_query" "q_ins_fraud_by_severity" {
  for_each = local.user_dbs
  data_source_id = databricks_sql_endpoint.isv_summit.data_source_id
  name           = "${each.key} Insurance Fraud by severity"
  query          = <<-EOT
    SELECT
        insured_hobbies,
        incident_severity,
        sum(case when prediction=1 then 1 else 0 end) as fraud_predicted,
        sum(case when prediction=1 then total_claim_amount else 0 end) as total_claim_amount,
        sum(case when prediction=1 then incident_weekend_flag else 0 end) as fraud_incident_weekend_flag,
        sum(case when prediction=0 then incident_weekend_flag else 0 end) as valid_incident_weekend_flag
    FROM ${each.value.db_name}.insurance_claims_gold
    GROUP BY insured_hobbies, incident_severity
  EOT
  run_as_role    = "viewer"
}

resource "databricks_permissions" "q_ins_fraud_by_severity_permission" {
  for_each = { for k, q in databricks_sql_query.q_ins_fraud_by_severity: k => q if k != data.databricks_current_user.me.user_name }
  sql_query_id = each.value.id

  // You can only specify "CAN_EDIT" permissions if the query `run_as_role` equals `viewer`.
  access_control {
    user_name       = each.key
    permission_level = "CAN_EDIT"
  }
}

resource "databricks_sql_visualization" "q_ins_fraud_by_severity_viz_table" {
  for_each = databricks_sql_query.q_ins_fraud_by_severity
  lifecycle {
    ignore_changes = [
        options
    ]
  }
  query_id    = each.value.id
  type        = "TABLE"
  name        = "Table"
  description = ""
  options = jsonencode({})
}

resource "databricks_sql_query" "q_ins_fraud_fitted" {
  for_each = local.user_dbs
  data_source_id = databricks_sql_endpoint.isv_summit.data_source_id
  name           = "${each.key} Insurance Fraud fitted"
  query          = <<-EOT
    SELECT
        CASE WHEN fraud_reported=1 THEN 'Yes' ELSE 'No' END as fraud_reported,
        count(*) as count
    FROM ${each.value.db_name}.insurance_claims_features a
    JOIN ${each.value.db_name}.insurance_claims_response b ON a.policy_number = b.policy_number
                                                                AND a.injury_claim = b.injury_claim
                                                                AND a.property_claim = b.property_claim 
                                                                AND a.vehicle_claim = b.vehicle_claim
    GROUP BY fraud_reported
  EOT
  run_as_role    = "viewer"
}

resource "databricks_permissions" "q_ins_fraud_fitted_permission" {
  for_each = { for k, q in databricks_sql_query.q_ins_fraud_fitted: k => q if k != data.databricks_current_user.me.user_name }
  sql_query_id = each.value.id

  // You can only specify "CAN_EDIT" permissions if the query `run_as_role` equals `viewer`.
  access_control {
    user_name       = each.key
    permission_level = "CAN_EDIT"
  }
}

resource "databricks_sql_visualization" "q_ins_fraud_fitted_viz_table" {
  for_each = databricks_sql_query.q_ins_fraud_fitted
  lifecycle {
    ignore_changes = [
        options
    ]
  }
  query_id    = each.value.id
  type        = "TABLE"
  name        = "Table"
  description = ""
  options = jsonencode({})
}

resource "databricks_sql_query" "q_ins_fraud_percent" {
  for_each = local.user_dbs
  data_source_id = databricks_sql_endpoint.isv_summit.data_source_id
  name           = "${each.key} Insurance Fraud percent"
  query          = <<-EOT
    SELECT
        CASE WHEN prediction=1 THEN 'Yes' ELSE 'No' END as fraud_predicted,
        round(count(*) / (SELECT count(*) FROM ${each.value.db_name}.insurance_claims_gold) * 100.0, 2) as percent
    FROM
        ${each.value.db_name}.insurance_claims_gold
    GROUP BY prediction
  EOT
  run_as_role    = "viewer"
}

resource "databricks_permissions" "q_ins_fraud_percent_permission" {
  for_each = { for k, q in databricks_sql_query.q_ins_fraud_percent: k => q if k != data.databricks_current_user.me.user_name }
  sql_query_id = each.value.id

  // You can only specify "CAN_EDIT" permissions if the query `run_as_role` equals `viewer`.
  access_control {
    user_name       = each.key
    permission_level = "CAN_EDIT"
  }
}

resource "databricks_sql_visualization" "q_ins_fraud_percent_viz_table" {
  for_each = databricks_sql_query.q_ins_fraud_percent
  lifecycle {
    ignore_changes = [
        options
    ]
  }
  query_id    = each.value.id
  type        = "TABLE"
  name        = "Table"
  description = ""
  options = jsonencode({})
}

resource "databricks_sql_query" "q_ins_fraud_hobbies" {
  for_each = local.user_dbs
  data_source_id = databricks_sql_endpoint.isv_summit.data_source_id
  name           = "${each.key} Insurance Fraud by hobbies"
  query          = <<-EOT
    SELECT
        insured_hobbies,
        sum(case when prediction=1 then 1 else 0 end) as prediction,
        count(case when prediction=1 then 1 else null end) as hobbies_count,
        sum(case when prediction=1 then total_claim_amount else 0 end) as total_fraud_claim_amount,
        sum(case when prediction=0 then total_claim_amount else 0 end) as total_valid_claim_amount,
        sum(case when prediction=1 then incident_weekend_flag else 0 end)/sum(incident_weekend_flag) * 100.0 as incident_weekend_flag
    FROM ${each.value.db_name}.insurance_claims_gold
    GROUP BY insured_hobbies
  EOT
  run_as_role    = "viewer"
}

resource "databricks_permissions" "q_ins_fraud_hobbies_permission" {
  for_each = { for k, q in databricks_sql_query.q_ins_fraud_hobbies: k => q if k != data.databricks_current_user.me.user_name }
  sql_query_id = each.value.id

  // You can only specify "CAN_EDIT" permissions if the query `run_as_role` equals `viewer`.
  access_control {
    user_name       = each.key
    permission_level = "CAN_EDIT"
  }
}

resource "databricks_sql_visualization" "q_ins_fraud_hobbies_viz_table" {
  for_each = databricks_sql_query.q_ins_fraud_hobbies
  lifecycle {
    ignore_changes = [
        options
    ]
  }
  query_id    = each.value.id
  type        = "TABLE"
  name        = "Table"
  description = ""
  options = jsonencode({})
}
