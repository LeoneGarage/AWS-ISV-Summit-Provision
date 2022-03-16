locals {
    job_cluster_key = "InsurancePipeline_cluster"
}

resource "databricks_job" "job_pipeline" {
  name = "${data.databricks_current_user.me.user_name}_InsurancePipeline"

  job_cluster {
    job_cluster_key = local.job_cluster_key
    new_cluster {
        num_workers = 0
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
        spark_version = data.databricks_spark_version.ml.id
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
            instance_profile_arn = "arn:aws:iam::997819012307:instance-profile/psa-glue-role"
        }
    }
  }

  task {
    task_key = "Initialize"
    job_cluster_key = local.job_cluster_key

    notebook_task {
      notebook_path = "${databricks_repo.insurance_fraud_repo.path}/Initialize"
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
      notebook_path = "${databricks_repo.insurance_fraud_repo.path}/ingestion/00_etl_streaming_bronze"
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
      notebook_path = "${databricks_repo.insurance_fraud_repo.path}/ingestion/10_etl_streaming_silver"
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
      notebook_path = "${databricks_repo.insurance_fraud_repo.path}/features/20_features"
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
      notebook_path = "${databricks_repo.insurance_fraud_repo.path}/inference/40_inference"
      base_parameters = {
          triggerOnce: "false"
      }
    }
  }
}