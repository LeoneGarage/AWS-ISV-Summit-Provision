# resource "databricks_repo" "insurance_fraud_repo" {
#   url = "https://github.com/LeoneGarage/AWS-ISV-Summit.git"
#   path = "${data.databricks_current_user.me.repos}/AWS-ISV-Summit"
# }

resource "databricks_repo" "insurance_fraud__user_repo" {
  for_each = local.all_users
  url = "https://github.com/LeoneGarage/AWS-ISV-Summit.git"
  path = each.value.user_name == data.databricks_current_user.me.user_name ? "${data.databricks_current_user.me.repos}/ISV-Summit" : "/Repos/${each.value.user_name}/ISV-Summit"
}

resource "databricks_permissions" "repo_usage" {
  for_each = { for k, r in local.all_users: k => r if k != data.databricks_current_user.me.user_name }
  repo_id = one([for r in databricks_repo.insurance_fraud__user_repo: r if r.path == "/Repos/${each.value.user_name}/ISV-Summit"]).id

  access_control {
    user_name        = each.value.user_name
    permission_level = "CAN_MANAGE"
  }
}

resource "null_resource" "insurance_fraud__user_repo_pull" {
  for_each = databricks_repo.insurance_fraud__user_repo
  triggers = {
    timestamp = "${timestamp()}"
    id = "${each.value.id}"
  }

  provisioner "local-exec" {
    command=<<EOT
    curl -X PATCH -H "Authorization: Bearer ${var.workspace_token}" -H 'Content-Type: application/json' ${var.workspace_host}/api/2.0/repos/${each.value.id} -d '
    {
      "branch": "master"
    }
    '
    EOT
  }
}