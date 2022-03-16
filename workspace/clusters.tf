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
  driver_node_type_id     = "c4.4xlarge"
  autotermination_minutes = 30
  autoscale {
    min_workers = 2
    max_workers = 8
  }
  spark_conf = {
    "spark.databricks.hive.metastore.glueCatalog.enabled" : true
  }
  spark_env_vars = {
      "PYSPARK_PYTHON" : "/databricks/python3/bin/python3"
  }
  custom_tags = var.tags

  aws_attributes {
    first_on_demand = 1
    availability = "SPOT_WITH_FALLBACK"
    zone_id = "auto"
    spot_bid_price_percent = 100
    ebs_volume_type = "GENERAL_PURPOSE_SSD"
    ebs_volume_count = 3
    ebs_volume_size = 100
    instance_profile_arn = "arn:aws:iam::997819012307:instance-profile/psa-glue-role"
#        instance_profile_arn           = databricks_instance_profile.initial.instance_profile_arn
  }
}