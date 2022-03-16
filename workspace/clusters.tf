data "databricks_node_type" "interactive_node" {
  local_disk = true
  min_cores   = 4
  gb_per_core = 2
  category = "Storage Optimized"
}

data "databricks_spark_version" "ml" {
  ml  = true
  latest = true
}

resource "databricks_cluster" "interactive_cluster" {
  cluster_name            = "aws-isv-summit"
  spark_version           = data.databricks_spark_version.ml.id
  node_type_id            = "i3.xlarge"#data.databricks_node_type.interactive_node.id
  autotermination_minutes = 30
  autoscale {
    min_workers = 2
    max_workers = 8
  }
  spark_env_vars = {
      "PYSPARK_PYTHON" : "/databricks/python3/bin/python3"
  }
  custom_tags = var.tags

  # aws_attributes {
  #   instance_profile_arn           = databricks_instance_profile.initial.instance_profile_arn
  # }
}