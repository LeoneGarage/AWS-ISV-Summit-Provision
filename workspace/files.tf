resource "databricks_dbfs_file" "files_fit" {
  source = "${path.module}/../data/files/insurance_claims.csv"
  path   = "/mnt/fraud/insurance/files/insurance_claims.csv"
}

resource "databricks_dbfs_file" "files_incoming" {
  source = "${path.module}/../data/files/insurance_claims_incoming.csv"
  path   = "/mnt/fraud/insurance/files/insurance_claims_incoming.csv"
}

resource "databricks_dbfs_file" "fitting" {
  source = "${path.module}/../data/fitting/insurance_claims.csv"
  path   = "/mnt/fraud/insurance/fitting/insurance_claims.csv"
}

resource "databricks_dbfs_file" "incoming" {
  source = "${path.module}/../data/incoming/insurance_claims_incoming.csv"
  path   = "/mnt/fraud/insurance/incoming/insurance_claims_incoming.csv"
}
