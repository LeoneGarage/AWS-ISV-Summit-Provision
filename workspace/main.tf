terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.5.2"
    }
  }
}

provider "databricks" {
  host  = var.workspace_host
  token = var.workspace_token
}

output "databricks_host" {
  value = var.workspace_host
}
