locals {
    job_cluster_key = "InsurancePipeline_cluster"
}

resource "databricks_job" "job_pipeline" {
  for_each = databricks_user.users
  name = "${each.value.user_name}_InsurancePipeline"

  job_cluster {
    job_cluster_key = local.job_cluster_key
    new_cluster {
        num_workers = 0
        autoscale {
            min_workers = 2
            max_workers = 8
        }
        spark_env_vars = {
            "PYSPARK_PYTHON" : "/databricks/python3/bin/python3"
        }
        custom_tags = var.tags
        spark_version = data.databricks_spark_version.ml.id
        policy_id   = databricks_cluster_policy.isv_summit.id
        node_type_id  = "i3.xlarge"#data.databricks_node_type.smallest.id
        driver_node_type_id = "c4.4xlarge"
        aws_attributes {
            first_on_demand = 1
            availability = "SPOT_WITH_FALLBACK"
            zone_id = "auto"
            spot_bid_price_percent = 100
            ebs_volume_type = "GENERAL_PURPOSE_SSD"
            ebs_volume_count = 3
            ebs_volume_size = 100
        }
    }
  }

  task {
    task_key = "Initialize"
    job_cluster_key = local.job_cluster_key

    notebook_task {
      notebook_path = "/Repos/${each.value.user_name}/AWS-ISV-Summit/Initialize"
      base_parameters = {
          triggerOnce: "false"
      }
    }
  }

  task {
    task_key = "Bronze"
    job_cluster_key = local.job_cluster_key

    depends_on {
      task_key = "Initialize"
    }
    notebook_task {
      notebook_path = "/Repos/${each.value.user_name}/AWS-ISV-Summit/ingestion/00_etl_streaming_bronze"
      base_parameters = {
          triggerOnce: "false"
      }
    }
  }

  task {
    task_key = "Silver"
    job_cluster_key = local.job_cluster_key

    depends_on {
      task_key = "Initialize"
    }
    notebook_task {
      notebook_path = "/Repos/${each.value.user_name}/AWS-ISV-Summit/ingestion/10_etl_streaming_silver"
      base_parameters = {
          triggerOnce: "false"
      }
    }
  }

  task {
    task_key = "Features"
    job_cluster_key = local.job_cluster_key

    depends_on {
      task_key = "Initialize"
    }
    notebook_task {
      notebook_path = "/Repos/${each.value.user_name}/AWS-ISV-Summit/features/20_features"
      base_parameters = {
          triggerOnce: "false"
      }
    }
  }

  task {
    task_key = "Gold_Inference"
    job_cluster_key = local.job_cluster_key

    depends_on {
      task_key = "Initialize"
    }
    notebook_task {
      notebook_path = "/Repos/${each.value.user_name}/AWS-ISV-Summit/inference/40_inference"
      base_parameters = {
          triggerOnce: "false"
      }
    }
  }
}

resource "databricks_permissions" "job_usage" {
  for_each = databricks_job.job_pipeline
  job_id = each.value.id

  access_control {
    user_name       = trimsuffix(each.value.name, "_InsurancePipeline")
    permission_level = "IS_OWNER"
  }
}