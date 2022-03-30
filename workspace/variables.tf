variable "databricks_account_name" {
  default = ""
}

variable "workspace_host" {
  default = ""
}

variable "workspace_token" {
  default = ""
}

variable "workspace" {
  default = ""
}

variable "tags" {
  default = {}
}

variable "datasource_id" {
  default = "48dfdc3c-dd99-4578-a146-d7eaadc38c75"#"ffd24ff6-6b31-451b-87b9-5fe4500e7fcf"
}

variable "users_filepath" {
  default = ""
}

data "local_file" "users" {
  filename = var.users_filepath
}

locals {
  users = csvdecode(data.local_file.users.content)
}