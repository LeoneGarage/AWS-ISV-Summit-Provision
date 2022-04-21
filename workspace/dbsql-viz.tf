
resource "databricks_sql_visualization" "q_ins_fraud_by_severity_viz_pie" {
  for_each = databricks_sql_query.q_ins_fraud_by_severity
  lifecycle {
    ignore_changes = [
        options
    ]
  }
  query_id    = each.value.id
  type        = "CHART"
  name        = "Pie"
  description = ""
  options = jsonencode({
        "alignYAxesAtZero": false,
        "coefficient": 1,
        "columnConfigurationMap": {
            "series": {
                "column": null
            },
            "x": {
                "column": "incident_severity"
            },
            "y": [
                {
                    "column": "fraud_predicted"
                }
            ]
        },
        "dateTimeFormat": "YYYY-MM-DD HH:mm",
        "direction": {
            "type": "counterclockwise"
        },
        "error_y": {
            "type": "data",
            "visible": true
        },
        "globalSeriesType": "pie",
        "legend": {
            "enabled": true,
            "placement": "auto",
            "traceorder": "normal"
        },
        "missingValuesAsZero": true,
        "numberFormat": "0,0[.]00000",
        "percentFormat": "0[.]00%",
        "series": {
            "error_y": {
                "type": "data",
                "visible": true
            },
            "stacking": null
        },
        "seriesOptions": {
            "0": {
                "name": "No Fraud Predicted"
            },
            "1": {
                "name": "Fraud Predicted"
            },
            "fraud_predicted": {
                "name": "Fraud Predicted"
            }
        },
        "showDataLabels": true,
        "showPlotlyControls": true,
        "sizemode": "diameter",
        "sortX": true,
        "swappedAxes": false,
        "textFormat": "",
        "valuesOptions": {},
        "version": 2,
        "xAxis": {
            "labels": {
                "enabled": true
            },
            "title": {
                "text": "Incident Severity"
            },
            "type": "-"
        },
        "yAxis": [
            {
                "title": {
                    "text": "Fraud Predicted"
                },
                "type": "linear"
            },
            {
                "opposite": true,
                "title": {
                    "text": null
                },
                "type": "linear"
            }
        ]
    })
}

resource "databricks_sql_visualization" "q_ins_fraud_by_severity_viz_weekend_fraud" {
  for_each = databricks_sql_query.q_ins_fraud_by_severity
  lifecycle {
    ignore_changes = [
        options
    ]
  }
  query_id    = each.value.id
  type        = "CHART"
  name        = "Weekend fraud"
  description = ""
  options = jsonencode({
        "alignYAxesAtZero": false,
        "coefficient": 1,
        "columnConfigurationMap": {
            "x": {
                "column": "insured_hobbies"
            },
            "y": [
                {
                    "column": "fraud_incident_weekend_flag"
                },
                {
                    "column": "valid_incident_weekend_flag"
                }
            ]
        },
        "dateTimeFormat": "YYYY-MM-DD HH:mm",
        "direction": {
            "type": "counterclockwise"
        },
        "error_y": {
            "type": "data",
            "visible": true
        },
        "globalSeriesType": "column",
        "legend": {
            "enabled": true,
            "placement": "auto",
            "traceorder": "normal"
        },
        "missingValuesAsZero": true,
        "numberFormat": "0,0[.]00000",
        "percentFormat": "0[.]00%",
        "series": {
            "error_y": {
                "type": "data",
                "visible": true
            },
            "stacking": null
        },
        "seriesOptions": {},
        "showDataLabels": false,
        "showPlotlyControls": true,
        "sizemode": "diameter",
        "sortX": true,
        "textFormat": "",
        "valuesOptions": {},
        "version": 2,
        "xAxis": {
            "labels": {
                "enabled": true
            },
            "title": {
                "text": "Insured Hobbies"
            },
            "type": "-"
        },
        "yAxis": [
            {
                "title": {
                    "text": "Fraud Weekend Incident"
                },
                "type": "linear"
            },
            {
                "opposite": true,
                "title": {
                    "text": "Valid Weekend Incident"
                },
                "type": "linear"
            }
        ]
    })
}

resource "databricks_sql_visualization" "q_ins_fraud_by_severity_viz_severity_by_hobbies" {
  for_each = databricks_sql_query.q_ins_fraud_by_severity
  lifecycle {
    ignore_changes = [
        options
    ]
  }
  query_id    = each.value.id
  type        = "CHART"
  name        = "Severity by hobbies"
  description = ""
  options = jsonencode({
        "alignYAxesAtZero": false,
        "coefficient": 1,
        "columnConfigurationMap": {
            "series": {
                "column": "incident_severity"
            },
            "x": {
                "column": "insured_hobbies"
            },
            "y": [
                {
                    "column": "fraud_predicted"
                }
            ]
        },
        "dateTimeFormat": "YYYY-MM-DD HH:mm",
        "direction": {
            "type": "counterclockwise"
        },
        "error_y": {
            "type": "data",
            "visible": true
        },
        "globalSeriesType": "column",
        "legend": {
            "enabled": true,
            "placement": "auto",
            "traceorder": "normal"
        },
        "missingValuesAsZero": true,
        "numberFormat": "0,0[.]00000",
        "percentFormat": "0[.]00%",
        "series": {
            "error_y": {
                "type": "data",
                "visible": true
            },
            "stacking": null
        },
        "seriesOptions": {
            "Total Loss": {
                "yAxis": 0
            },
            "total_claim_amount": {
                "name": "Total Claim Amount"
            }
        },
        "showDataLabels": false,
        "showPlotlyControls": true,
        "sizemode": "diameter",
        "sortX": true,
        "textFormat": "",
        "valuesOptions": {},
        "version": 2,
        "xAxis": {
            "labels": {
                "enabled": true
            },
            "title": {
                "text": "Hobbies"
            },
            "type": "-"
        },
        "yAxis": [
            {
                "title": {
                    "text": "Fraud Predicted"
                },
                "type": "linear"
            },
            {
                "opposite": true,
                "title": {
                    "text": null
                },
                "type": "linear"
            }
        ]
    })
}

resource "databricks_sql_visualization" "q_ins_fraud_fitted_viz_fraud_reported" {
  for_each = databricks_sql_query.q_ins_fraud_fitted
  lifecycle {
    ignore_changes = [
        options
    ]
  }
  query_id    = each.value.id
  type        = "CHART"
  name        = "Fraud reported"
  description = ""
  options = jsonencode({
        "alignYAxesAtZero": false,
        "coefficient": 1,
        "columnConfigurationMap": {
            "x": {
                "column": "fraud_reported"
            },
            "y": [
                {
                    "column": "count"
                }
            ]
        },
        "dateTimeFormat": "YYYY-MM-DD HH:mm",
        "direction": {
            "type": "counterclockwise"
        },
        "error_y": {
            "type": "data",
            "visible": true
        },
        "globalSeriesType": "column",
        "legend": {
            "enabled": true,
            "placement": "auto",
            "traceorder": "normal"
        },
        "missingValuesAsZero": true,
        "numberFormat": "0,0[.]00000",
        "percentFormat": "0[.]00%",
        "series": {
            "error_y": {
                "type": "data",
                "visible": true
            },
            "stacking": null
        },
        "seriesOptions": {
            "count": {
                "name": "Total Fraud",
                "yAxis": 0
            }
        },
        "showDataLabels": true,
        "showPlotlyControls": true,
        "sizemode": "diameter",
        "sortX": true,
        "swappedAxes": false,
        "textFormat": "",
        "valuesOptions": {},
        "version": 2,
        "xAxis": {
            "labels": {
                "enabled": true
            },
            "title": {
                "text": "Fraud"
            },
            "type": "-"
        },
        "yAxis": [
            {
                "rangeMax": null,
                "rangeMin": null,
                "title": {
                    "text": "Total Fraud"
                },
                "type": "linear"
            },
            {
                "opposite": true,
                "title": {
                    "text": null
                },
                "type": "linear"
            }
        ]
    })
}

resource "databricks_sql_visualization" "q_ins_fraud_percent_viz_fraud" {
  for_each = databricks_sql_query.q_ins_fraud_percent
  lifecycle {
    ignore_changes = [
        options
    ]
  }
  query_id    = each.value.id
  type        = "CHART"
  name        = "Fraud"
  description = ""

  // The options encoded in this field are passed verbatim to the SQLA API.
  options = jsonencode({
        "alignYAxesAtZero": false,
        "coefficient": 1,
        "columnConfigurationMap": {
            "x": {
                "column": "fraud_predicted"
            },
            "y": [
                {
                    "column": "percent"
                }
            ]
        },
        "dateTimeFormat": "YYYY-MM-DD HH:mm",
        "direction": {
            "type": "counterclockwise"
        },
        "error_y": {
            "type": "data",
            "visible": true
        },
        "globalSeriesType": "column",
        "legend": {
            "enabled": true,
            "placement": "auto",
            "traceorder": "normal"
        },
        "missingValuesAsZero": true,
        "numberFormat": "0,0[.]00%",
        "percentFormat": "0[.]00%",
        "run_as_role": "viewer",
        "series": {
            "error_y": {
                "type": "data",
                "visible": true
            },
            "stacking": null
        },
        "seriesOptions": {
            "count": {
                "name": "Total"
            }
        },
        "showDataLabels": true,
        "showPlotlyControls": true,
        "sizemode": "diameter",
        "sortX": true,
        "textFormat": "",
        "valuesOptions": {},
        "version": 2,
        "xAxis": {
            "labels": {
                "enabled": true
            },
            "title": {
                "text": "Fraud Predicted"
            },
            "type": "-"
        },
        "yAxis": [
            {
                "title": {
                    "text": "percent"
                },
                "type": "linear"
            },
            {
                "opposite": true,
                "title": {
                    "text": null
                },
                "type": "linear"
            }
        ]
    })
}

resource "databricks_sql_visualization" "q_ins_fraud_hobbies_viz_fraud_pie" {
  for_each = databricks_sql_query.q_ins_fraud_hobbies
  lifecycle {
    ignore_changes = [
        options
    ]
  }
  query_id    = each.value.id
  type        = "CHART"
  name        = "Fraud pie"
  description = ""
  options = jsonencode({
        "alignYAxesAtZero": false,
        "coefficient": 1,
        "columnConfigurationMap": {
            "series": {
                "column": null
            },
            "x": {
                "column": "insured_hobbies"
            },
            "y": [
                {
                    "column": "hobbies_count"
                }
            ]
        },
        "dateTimeFormat": "YYYY-MM-DD HH:mm",
        "direction": {
            "type": "counterclockwise"
        },
        "error_y": {
            "type": "data",
            "visible": true
        },
        "globalSeriesType": "pie",
        "legend": {
            "enabled": true,
            "placement": "auto",
            "traceorder": "normal"
        },
        "missingValuesAsZero": true,
        "numberFormat": "0,0[.]00000",
        "percentFormat": "0[.]00%",
        "series": {
            "error_y": {
                "type": "data",
                "visible": true
            },
            "stacking": null
        },
        "seriesOptions": {
            "0": {
                "name": "No Fraud Predicted"
            },
            "1": {
                "name": "Fraud Predicted"
            },
            "hobbies_count": {
                "name": "Hobby Fraud ratios"
            }
        },
        "showDataLabels": true,
        "showPlotlyControls": true,
        "sizemode": "diameter",
        "sortX": true,
        "swappedAxes": false,
        "textFormat": "",
        "valuesOptions": {},
        "version": 2,
        "xAxis": {
            "labels": {
                "enabled": true
            },
            "title": {
                "text": "Insured Hobbies"
            },
            "type": "-"
        },
        "yAxis": [
            {
                "title": {
                    "text": "Hobbies Count"
                },
                "type": "linear"
            },
            {
                "opposite": true,
                "title": {
                    "text": null
                },
                "type": "linear"
            }
        ]
    })
}

resource "databricks_sql_visualization" "q_ins_fraud_hobbies_viz_claim_amount" {
  for_each = databricks_sql_query.q_ins_fraud_hobbies
  lifecycle {
    ignore_changes = [
        options
    ]
  }
  query_id    = each.value.id
  type        = "CHART"
  name        = "Claim Amount"
  description = ""
  options = jsonencode({
        "alignYAxesAtZero": false,
        "coefficient": 1,
        "columnConfigurationMap": {
            "series": {
                "column": null
            },
            "x": {
                "column": "insured_hobbies"
            },
            "y": [
                {
                    "column": "total_fraud_claim_amount"
                },
                {
                    "column": "total_valid_claim_amount"
                }
            ]
        },
        "dateTimeFormat": "YYYY-MM-DD HH:mm",
        "direction": {
            "type": "counterclockwise"
        },
        "error_y": {
            "type": "data",
            "visible": true
        },
        "globalSeriesType": "column",
        "legend": {
            "enabled": true,
            "placement": "auto",
            "traceorder": "normal"
        },
        "missingValuesAsZero": true,
        "numberFormat": "0,0[.]00000",
        "percentFormat": "0[.]00%",
        "series": {
            "error_y": {
                "type": "data",
                "visible": true
            },
            "stacking": null
        },
        "seriesOptions": {
            "total_claim_amount": {
                "name": "Total Claim Amount"
            }
        },
        "showDataLabels": false,
        "showPlotlyControls": true,
        "sizemode": "diameter",
        "sortX": true,
        "textFormat": "",
        "valuesOptions": {},
        "version": 2,
        "xAxis": {
            "labels": {
                "enabled": true
            },
            "title": {
                "text": "Hobbies"
            },
            "type": "-"
        },
        "yAxis": [
            {
                "title": {
                    "text": "Total Fraud Claim Amount"
                },
                "type": "linear"
            },
            {
                "opposite": true,
                "title": {
                    "text": "Total Valid Claim Amount"
                },
                "type": "linear"
            }
        ]
    })
}

resource "databricks_sql_visualization" "q_ins_fraud_hobbies_viz_weekend" {
  for_each = databricks_sql_query.q_ins_fraud_hobbies
  lifecycle {
    ignore_changes = [
        options
    ]
  }
  query_id    = each.value.id
  type        = "CHART"
  name        = "Weekend"
  description = ""
  options = jsonencode({
        "alignYAxesAtZero": false,
        "coefficient": 1,
        "columnConfigurationMap": {
            "x": {
                "column": "insured_hobbies"
            },
            "y": [
                {
                    "column": "incident_weekend_flag"
                }
            ]
        },
        "dateTimeFormat": "YYYY-MM-DD HH:mm",
        "direction": {
            "type": "counterclockwise"
        },
        "error_y": {
            "type": "data",
            "visible": true
        },
        "globalSeriesType": "column",
        "legend": {
            "enabled": true,
            "placement": "auto",
            "traceorder": "normal"
        },
        "missingValuesAsZero": true,
        "numberFormat": "0,0[.]00000",
        "percentFormat": "0[.]00%",
        "series": {
            "error_y": {
                "type": "data",
                "visible": true
            },
            "stacking": null
        },
        "seriesOptions": {},
        "showDataLabels": false,
        "showPlotlyControls": true,
        "sizemode": "diameter",
        "sortX": true,
        "textFormat": "",
        "valuesOptions": {},
        "version": 2,
        "xAxis": {
            "labels": {
                "enabled": true
            },
            "title": {
                "text": "Insured Hobbies"
            },
            "type": "-"
        },
        "yAxis": [
            {
                "title": {
                    "text": "Weekend Incident"
                },
                "type": "linear"
            },
            {
                "opposite": true,
                "title": {
                    "text": null
                },
                "type": "linear"
            }
        ]
    })
}
