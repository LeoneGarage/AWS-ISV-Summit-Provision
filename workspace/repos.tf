# resource "databricks_repo" "insurance_fraud_repo" {
#   url = "https://github.com/LeoneGarage/AWS-ISV-Summit.git"
#   path = "${data.databricks_current_user.me.repos}/AWS-ISV-Summit"
# }

resource "databricks_repo" "insurance_fraud__user_repo" {
  for_each = databricks_user.users
  url = "https://github.com/LeoneGarage/AWS-ISV-Summit.git"
  path = "/Repos/${each.value.user_name}/AWS-ISV-Summit"
}

resource "databricks_permissions" "repo_usage" {
  for_each = databricks_user.users
  repo_id = one([for r in databricks_repo.insurance_fraud__user_repo: r if r.path == "/Repos/${each.value.user_name}/AWS-ISV-Summit"]).id

  access_control {
    user_name        = each.value.user_name
    permission_level = "CAN_MANAGE"
  }
}