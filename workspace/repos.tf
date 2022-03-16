resource "databricks_repo" "insurance_fraud_repo" {
  url = "https://github.com/LeoneGarage/AWS-ISV-Summit.git"
  path = "${data.databricks_current_user.me.repos}/AWS-ISV-Summit"
}
