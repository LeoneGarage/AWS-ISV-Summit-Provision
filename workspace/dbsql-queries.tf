resource "databricks_sql_query" "q_ins_fraud_by_severity" {
  data_source_id = var.datasource_id
  name           = "Insurance Fraud by severity"
  query          = <<-EOT
    SELECT
        insured_hobbies,
        incident_severity,
        sum(case when prediction=1 then 1 else 0 end) as fraud_predicted,
        sum(case when prediction=1 then total_claim_amount else 0 end) as total_claim_amount,
        sum(case when prediction=1 then incident_weekend_flag else 0 end) as fraud_incident_weekend_flag,
        sum(case when prediction=0 then incident_weekend_flag else 0 end) as valid_incident_weekend_flag
    FROM leon_eller_gold.insurance_claims
    GROUP BY insured_hobbies, incident_severity
  EOT
  run_as_role    = "viewer"
}

resource "databricks_sql_visualization" "q_ins_fraud_by_severity_viz_table" {
  query_id    = databricks_sql_query.q_ins_fraud_by_severity.id
  type        = "TABLE"
  name        = "Table"
  description = ""
  options = jsonencode({})
}

resource "databricks_sql_query" "q_ins_fraud_fitted" {
  data_source_id = var.datasource_id
  name           = "Insurance Fraud fitted"
  query          = <<-EOT
    SELECT
        CASE WHEN fraud_reported=1 THEN 'Yes' ELSE 'No' END as fraud_reported,
        count(*) as count
    FROM leon_eller_features.insurance_fraud_features a
    JOIN leon_eller_features.insurance_claims_response b ON a.policy_number = b.policy_number
                                                                AND a.injury_claim = b.injury_claim
                                                                AND a.property_claim = b.property_claim 
                                                                AND a.vehicle_claim = b.vehicle_claim
    GROUP BY fraud_reported
  EOT
  run_as_role    = "viewer"
}

resource "databricks_sql_visualization" "q_ins_fraud_fitted_viz_table" {
  query_id    = databricks_sql_query.q_ins_fraud_fitted.id
  type        = "TABLE"
  name        = "Table"
  description = ""
  options = jsonencode({})
}

resource "databricks_sql_query" "q_ins_fraud_percent" {
  data_source_id = var.datasource_id
  name           = "Insurance Fraud percent"
  query          = <<-EOT
    SELECT
        CASE WHEN prediction=1 THEN 'Yes' ELSE 'No' END as fraud_predicted,
        round(count(*) / (SELECT count(*) FROM leon_eller_gold.insurance_claims) * 100.0, 2) as percent
    FROM
        leon_eller_gold.insurance_claims
    GROUP BY prediction
  EOT
  run_as_role    = "viewer"
}

resource "databricks_sql_visualization" "q_ins_fraud_percent_viz_table" {
  query_id    = databricks_sql_query.q_ins_fraud_percent.id
  type        = "TABLE"
  name        = "Table"
  description = ""
  options = jsonencode({})
}

resource "databricks_sql_query" "q_ins_fraud_hobbies" {
  data_source_id = var.datasource_id
  name           = "Insurance Fraud by hobbies"
  query          = <<-EOT
    SELECT
        insured_hobbies,
        sum(case when prediction=1 then 1 else 0 end) as prediction,
        count(case when prediction=1 then 1 else null end) as hobbies_count,
        sum(case when prediction=1 then total_claim_amount else 0 end) as total_fraud_claim_amount,
        sum(case when prediction=0 then total_claim_amount else 0 end) as total_valid_claim_amount,
        sum(case when prediction=1 then incident_weekend_flag else 0 end)/sum(incident_weekend_flag) * 100.0 as incident_weekend_flag
    FROM leon_eller_gold.insurance_claims
    GROUP BY insured_hobbies
  EOT
  run_as_role    = "viewer"
}

resource "databricks_sql_visualization" "q_ins_fraud_hobbies_viz_table" {
  query_id    = databricks_sql_query.q_ins_fraud_hobbies.id
  type        = "TABLE"
  name        = "Table"
  description = ""
  options = jsonencode({})
}
