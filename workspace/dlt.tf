resource "databricks_pipeline" "dlt_pipeline_sql" {
  for_each = local.user_dbs
  name = "${each.key}_InsurancePipeline_sql"
  configuration = {
    "fraud_pipeline.raw_path" = "/mnt/fraud/insurance/incoming"
    "fraud_pipeline.schema_path" = "/mnt/${each.value.db_name}/insurance/incoming_schema/etl_schema"
    "pipelines.applyChangesPreviewEnabled" = "true"
  }

  cluster {
    label       = "default"
    autoscale {
      min_workers = 1
      max_workers = 5
    }
  }

  cluster {
    label       = "maintenance"
    num_workers = 1
    custom_tags = {
      cluster_type = "maintenance"
    }
  }

  library {
    notebook {
      path = "/Repos/${each.key}/AWS-ISV-Summit/utils/udfs"
    }
  }
  library {
    notebook {
      path = "/Repos/${each.key}/AWS-ISV-Summit/dlt/sql/00_etl_dlt_bronze"
    }
  }
  library {
    notebook {
      path = "/Repos/${each.key}/AWS-ISV-Summit/dlt/sql/10_etl_dlt_silver"
    }
  }
  library {
    notebook {
      path = "/Repos/${each.key}/AWS-ISV-Summit/dlt/sql/20_etl_dlt_gold"
    }
  }

  filters {
    include = ["com.databricks.include"]
    exclude = ["com.databricks.exclude"]
  }

  continuous = false
  target = each.value.dlt_db_name

  provisioner "local-exec" {
    command=<<EOT
    curl -X PUT -H "Authorization: Bearer ${var.workspace_token}" -H 'Content-Type: application/json' ${var.workspace_host}/api/2.0/preview/permissions/pipelines/${self.id} -d '
    {
       "access_control_list": [
         {
           "user_name": "${trimsuffix(self.name, "_InsurancePipeline_sql")}",
           "permission_level": "IS_OWNER"
         }
       ]
    }'
    EOT
  }
}

resource "null_resource" "dlt_pipeline_sql_patch_policy_id" {
  for_each = databricks_pipeline.dlt_pipeline_sql
  triggers = {
    timestamp = "${timestamp()}"
    id = "${each.value.id}"
  }
  provisioner "local-exec" {
    command=<<EOT
    curl -X PUT -H "Authorization: Bearer ${var.workspace_token}" -H 'Content-Type: application/json' ${var.workspace_host}/api/2.0/pipelines/${each.value.id} -d '
{
    "id": "${each.value.id}",
    "clusters": [
        {
            "label": "default",
            "autoscale": {
                "min_workers": 1,
                "max_workers": 5
            },
            "policy_id": "${databricks_cluster_policy.isv_summit_dlt.id}"
        },
        {
            "label": "maintenance",
            "custom_tags": {
                "cluster_type": "maintenance"
            },
            "num_workers": 1,
            "policy_id": "${databricks_cluster_policy.isv_summit_dlt.id}"
        }
    ],
    "filters": {
        "include": [
            "com.databricks.include"
        ],
        "exclude": [
            "com.databricks.exclude"
        ]
    },
    "development": true,
    "continuous": false,
    "edition": "advanced",
    "libraries": [
        {
            "notebook": {
                "path": "/Repos/${each.key}/AWS-ISV-Summit/dlt/sql/00_etl_dlt_bronze"
            }
        },
        {
            "notebook": {
                "path": "/Repos/${each.key}/AWS-ISV-Summit/utils/udfs"
            }
        },
        {
            "notebook": {
                "path": "/Repos/${each.key}/AWS-ISV-Summit/dlt/sql/20_etl_dlt_gold"
            }
        },
        {
            "notebook": {
                "path": "/Repos/${each.key}/AWS-ISV-Summit/dlt/sql/10_etl_dlt_silver"
            }
        }
    ],
    "name": "${each.value.name}",
    "storage": "dbfs:/pipelines/${each.value.id}",
    "configuration": {
        "fraud_pipeline.raw_path": "/mnt/fraud/insurance/incoming",
        "fraud_pipeline.schema_path": "/mnt/${local.user_dbs[trimsuffix(each.value.name, "_InsurancePipeline_sql")].db_name}/insurance/incoming_schema/etl_schema",
        "pipelines.applyChangesPreviewEnabled": "true"
    },
    "target": "${local.user_dbs[trimsuffix(each.value.name, "_InsurancePipeline_sql")].dlt_db_name}"
}
    '
    EOT
  }
}

resource "databricks_pipeline" "dlt_pipeline_python" {
  for_each = local.user_dbs
  name = "${each.key}_InsurancePipeline_python"
  configuration = {
    "fraud_pipeline.raw_path" = "/mnt/fraud/insurance/incoming"
    "fraud_pipeline.schema_path" = "/mnt/${each.value.db_name}/insurance/incoming_schema/etl_schema"
    "pipelines.applyChangesPreviewEnabled" = "true"
  }

  cluster {
    label       = "default"
    autoscale {
      min_workers = 1
      max_workers = 5
    }
  }

  cluster {
    label       = "maintenance"
    num_workers = 1
    custom_tags = {
      cluster_type = "maintenance"
    }
  }

  library {
    notebook {
      path = "/Repos/${each.key}/AWS-ISV-Summit/utils/udfs"
    }
  }
  library {
    notebook {
      path = "/Repos/${each.key}/AWS-ISV-Summit/dlt/python/00_etl_dlt_bronze"
    }
  }
  library {
    notebook {
      path = "/Repos/${each.key}/AWS-ISV-Summit/dlt/python/10_etl_dlt_silver"
    }
  }
  library {
    notebook {
      path = "/Repos/${each.key}/AWS-ISV-Summit/dlt/python/20_etl_dlt_gold"
    }
  }

  filters {
    include = ["com.databricks.include"]
    exclude = ["com.databricks.exclude"]
  }

  continuous = false
  target = each.value.dlt_db_name

  provisioner "local-exec" {
    command=<<EOT
    curl -X PUT -H "Authorization: Bearer ${var.workspace_token}" -H 'Content-Type: application/json' ${var.workspace_host}/api/2.0/preview/permissions/pipelines/${self.id} -d '
    {
       "access_control_list": [
         {
           "user_name": "${trimsuffix(self.name, "_InsurancePipeline_python")}",
           "permission_level": "IS_OWNER"
         }
       ]
    }'
    EOT
  }
}

resource "null_resource" "dlt_pipeline_python_patch_policy_id" {
  for_each = databricks_pipeline.dlt_pipeline_python
  triggers = {
    timestamp = "${timestamp()}"
    id = "${each.value.id}"
  }

  provisioner "local-exec" {
    command=<<EOT
    curl -X PUT -H "Authorization: Bearer ${var.workspace_token}" -H 'Content-Type: application/json' ${var.workspace_host}/api/2.0/pipelines/${each.value.id} -d '
{
    "id": "${each.value.id}",
    "clusters": [
        {
            "label": "default",
            "autoscale": {
                "min_workers": 1,
                "max_workers": 5
            },
            "policy_id": "${databricks_cluster_policy.isv_summit_dlt.id}"
        },
        {
            "label": "maintenance",
            "custom_tags": {
                "cluster_type": "maintenance"
            },
            "num_workers": 1,
            "policy_id": "${databricks_cluster_policy.isv_summit_dlt.id}"
        }
    ],
    "filters": {
        "include": [
            "com.databricks.include"
        ],
        "exclude": [
            "com.databricks.exclude"
        ]
    },
    "development": true,
    "continuous": false,
    "edition": "advanced",
    "libraries": [
        {
            "notebook": {
                "path": "/Repos/${each.key}/AWS-ISV-Summit/dlt/python/00_etl_dlt_bronze"
            }
        },
        {
            "notebook": {
                "path": "/Repos/${each.key}/AWS-ISV-Summit/utils/udfs"
            }
        },
        {
            "notebook": {
                "path": "/Repos/${each.key}/AWS-ISV-Summit/dlt/python/20_etl_dlt_gold"
            }
        },
        {
            "notebook": {
                "path": "/Repos/${each.key}/AWS-ISV-Summit/dlt/python/10_etl_dlt_silver"
            }
        }
    ],
    "name": "${each.value.name}",
    "storage": "dbfs:/pipelines/${each.value.id}",
    "configuration": {
        "fraud_pipeline.raw_path": "/mnt/fraud/insurance/incoming",
        "fraud_pipeline.schema_path": "/mnt/${local.user_dbs[trimsuffix(each.value.name, "_InsurancePipeline_python")].db_name}/insurance/incoming_schema/etl_schema",
        "pipelines.applyChangesPreviewEnabled": "true"
    },
    "target": "${local.user_dbs[trimsuffix(each.value.name, "_InsurancePipeline_python")].dlt_db_name}"
}
    '
    EOT
  }
}