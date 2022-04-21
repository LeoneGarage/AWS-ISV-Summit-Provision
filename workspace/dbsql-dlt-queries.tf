resource "databricks_sql_query" "q_ins_claims_by_city" {
  for_each = local.user_dbs
  data_source_id = databricks_sql_endpoint.isv_summit.data_source_id
  name           = "${each.key} Insurance Claims by city"
  query          = <<-EOT
    SELECT incident_city, claim_amount
    FROM ${each.value.dlt_db_name}.insurance_claims_gold_claims_amounts
  EOT
  run_as_role    = "viewer"
}

resource "databricks_permissions" "q_ins_claims_by_city_permission" {
  for_each = { for k, q in databricks_sql_query.q_ins_claims_by_city: k => q if k != data.databricks_current_user.me.user_name }
  sql_query_id = each.value.id

  // You can only specify "CAN_EDIT" permissions if the query `run_as_role` equals `viewer`.
  access_control {
    user_name       = each.key
    permission_level = "IS_OWNER"
  }
}

resource "databricks_sql_visualization" "q_ins_claims_by_city_viz_table" {
  for_each = databricks_sql_query.q_ins_claims_by_city
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

resource "databricks_sql_query" "q_ins_claims_by_hobbies" {
  for_each = local.user_dbs
  data_source_id = databricks_sql_endpoint.isv_summit.data_source_id
  name           = "${each.key} Insurance Claims by hobbies"
  query          = <<-EOT
    SELECT insured_hobbies, claim_amount
    FROM ${each.value.dlt_db_name}.insurance_claims_gold_hobbies
  EOT
  run_as_role    = "viewer"
}

resource "databricks_permissions" "q_ins_claims_by_hobbies_permission" {
  for_each = { for k, q in databricks_sql_query.q_ins_claims_by_hobbies: k => q if k != data.databricks_current_user.me.user_name }
  sql_query_id = each.value.id

  // You can only specify "CAN_EDIT" permissions if the query `run_as_role` equals `viewer`.
  access_control {
    user_name       = each.key
    permission_level = "IS_OWNER"
  }
}

resource "databricks_sql_visualization" "q_ins_claims_by_hobbies_viz_table" {
  for_each = databricks_sql_query.q_ins_claims_by_hobbies
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

resource "databricks_sql_query" "q_ins_claims_by_auto_type" {
  for_each = local.user_dbs
  data_source_id = databricks_sql_endpoint.isv_summit.data_source_id
  name           = "${each.key} Insurance Claims by Auto type"
  query          = <<-EOT
    SELECT concat(auto_make, ' - ', auto_model) as auto_type, claim_amount
    FROM ${each.value.dlt_db_name}.insurance_claims_gold_auto_type
  EOT
  run_as_role    = "viewer"
}

resource "databricks_permissions" "q_ins_claims_by_auto_type_permission" {
  for_each = { for k, q in databricks_sql_query.q_ins_claims_by_auto_type: k => q if k != data.databricks_current_user.me.user_name }
  sql_query_id = each.value.id

  // You can only specify "CAN_EDIT" permissions if the query `run_as_role` equals `viewer`.
  access_control {
    user_name       = each.key
    permission_level = "IS_OWNER"
  }
}

resource "databricks_sql_visualization" "q_ins_claims_by_auto_type_viz_table" {
  for_each = databricks_sql_query.q_ins_claims_by_auto_type
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
