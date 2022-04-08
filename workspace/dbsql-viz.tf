
resource "databricks_sql_visualization" "q_ins_fraud_by_severity_viz_pie" {
  for_each = databricks_sql_query.q_ins_fraud_by_severity
  query_id    = each.value.id
  type        = "CHART"
  name        = "Pie"
  description = ""
  options = jsonencode(
      {
        "version": 2,
        "globalSeriesType": "pie",
        "sortX": true,
        "legend": {
            "enabled": true,
            "placement": "auto",
            "traceorder": "normal"
        },
        "xAxis": {
            "type": "-",
            "labels": {
                "enabled": true
            },
            "title": {
                "text": "Incident Severity"
            }
        },
        "yAxis": [
            {
                "type": "linear",
                "title": {
                    "text": "Fraud Predicted"
                }
            },
            {
                "type": "linear",
                "opposite": true,
                "title": {
                    "text": null
                }
            }
        ],
        "alignYAxesAtZero": false,
        "error_y": {
            "type": "data",
            "visible": true
        },
        "series": {
            "stacking": null,
            "error_y": {
                "type": "data",
                "visible": true
            }
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
        "valuesOptions": {},
        "direction": {
            "type": "counterclockwise"
        },
        "sizemode": "diameter",
        "coefficient": 1,
        "numberFormat": "0,0[.]00000",
        "percentFormat": "0[.]00%",
        "textFormat": "",
        "missingValuesAsZero": true,
        "showDataLabels": true,
        "dateTimeFormat": "YYYY-MM-DD HH:mm",
        "columnConfigurationMap": {
            "x": {
                "column": "incident_severity"
            },
            "y": [
                {
                    "column": "fraud_predicted"
                }
            ],
            "series": {
                "column": null
            }
        },
        "showPlotlyControls": true,
        "swappedAxes": false
    }
  )
}

resource "databricks_sql_visualization" "q_ins_fraud_by_severity_viz_weekend_fraud" {
  for_each = databricks_sql_query.q_ins_fraud_by_severity
  query_id    = each.value.id
  type        = "CHART"
  name        = "Weekend fraud"
  description = ""
  options = jsonencode({
                "version": 2,
                "globalSeriesType": "column",
                "sortX": true,
                "legend": {
                    "enabled": true,
                    "placement": "auto",
                    "traceorder": "normal"
                },
                "xAxis": {
                    "type": "-",
                    "labels": {
                        "enabled": true
                    },
                    "title": {
                        "text": "Insured Hobbies"
                    }
                },
                "yAxis": [
                    {
                        "type": "linear",
                        "title": {
                            "text": "Fraud Weekend Incident"
                        }
                    },
                    {
                        "type": "linear",
                        "opposite": true,
                        "title": {
                            "text": "Valid Weekend Incident"
                        }
                    }
                ],
                "alignYAxesAtZero": false,
                "error_y": {
                    "type": "data",
                    "visible": true
                },
                "series": {
                    "stacking": null,
                    "error_y": {
                        "type": "data",
                        "visible": true
                    }
                },
                "seriesOptions": {},
                "valuesOptions": {},
                "direction": {
                    "type": "counterclockwise"
                },
                "sizemode": "diameter",
                "coefficient": 1,
                "numberFormat": "0,0[.]00000",
                "percentFormat": "0[.]00%",
                "textFormat": "",
                "missingValuesAsZero": true,
                "showDataLabels": false,
                "dateTimeFormat": "YYYY-MM-DD HH:mm",
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
                "showPlotlyControls": true
            })
}

resource "databricks_sql_visualization" "q_ins_fraud_by_severity_viz_severity_by_hobbies" {
  for_each = databricks_sql_query.q_ins_fraud_by_severity
  query_id    = each.value.id
  type        = "CHART"
  name        = "Severity by hobbies"
  description = ""
  options = jsonencode({
                "version": 2,
                "globalSeriesType": "column",
                "sortX": true,
                "legend": {
                    "enabled": true,
                    "placement": "auto",
                    "traceorder": "normal"
                },
                "xAxis": {
                    "type": "-",
                    "labels": {
                        "enabled": true
                    },
                    "title": {
                        "text": "Hobbies"
                    }
                },
                "yAxis": [
                    {
                        "type": "linear",
                        "title": {
                            "text": "Fraud Predicted"
                        }
                    },
                    {
                        "type": "linear",
                        "opposite": true,
                        "title": {
                            "text": null
                        }
                    }
                ],
                "alignYAxesAtZero": false,
                "error_y": {
                    "type": "data",
                    "visible": true
                },
                "series": {
                    "stacking": null,
                    "error_y": {
                        "type": "data",
                        "visible": true
                    }
                },
                "seriesOptions": {
                    "total_claim_amount": {
                        "name": "Total Claim Amount"
                    },
                    "Total Loss": {
                        "yAxis": 0
                    }
                },
                "valuesOptions": {},
                "direction": {
                    "type": "counterclockwise"
                },
                "sizemode": "diameter",
                "coefficient": 1,
                "numberFormat": "0,0[.]00000",
                "percentFormat": "0[.]00%",
                "textFormat": "",
                "missingValuesAsZero": true,
                "showDataLabels": false,
                "dateTimeFormat": "YYYY-MM-DD HH:mm",
                "columnConfigurationMap": {
                    "x": {
                        "column": "insured_hobbies"
                    },
                    "y": [
                        {
                            "column": "fraud_predicted"
                        }
                    ],
                    "series": {
                        "column": "incident_severity"
                    }
                },
                "showPlotlyControls": true
            })
}

resource "databricks_sql_visualization" "q_ins_fraud_fitted_viz_fraud_reported" {
  for_each = databricks_sql_query.q_ins_fraud_fitted
  query_id    = each.value.id
  type        = "CHART"
  name        = "Fraud reported"
  description = ""
  options = jsonencode({
                "version": 2,
                "globalSeriesType": "column",
                "sortX": true,
                "legend": {
                    "enabled": true,
                    "placement": "auto",
                    "traceorder": "normal"
                },
                "xAxis": {
                    "type": "-",
                    "labels": {
                        "enabled": true
                    },
                    "title": {
                        "text": "Fraud"
                    }
                },
                "yAxis": [
                    {
                        "type": "linear",
                        "title": {
                            "text": "Total Fraud"
                        },
                        "rangeMax": null,
                        "rangeMin": null
                    },
                    {
                        "type": "linear",
                        "opposite": true,
                        "title": {
                            "text": null
                        }
                    }
                ],
                "alignYAxesAtZero": false,
                "error_y": {
                    "type": "data",
                    "visible": true
                },
                "series": {
                    "stacking": null,
                    "error_y": {
                        "type": "data",
                        "visible": true
                    }
                },
                "seriesOptions": {
                    "count": {
                        "name": "Total Fraud",
                        "yAxis": 0
                    }
                },
                "valuesOptions": {},
                "direction": {
                    "type": "counterclockwise"
                },
                "sizemode": "diameter",
                "coefficient": 1,
                "numberFormat": "0,0[.]00000",
                "percentFormat": "0[.]00%",
                "textFormat": "",
                "missingValuesAsZero": true,
                "showDataLabels": true,
                "dateTimeFormat": "YYYY-MM-DD HH:mm",
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
                "showPlotlyControls": true,
                "swappedAxes": false
            })
}

resource "databricks_sql_visualization" "q_ins_fraud_percent_viz_fraud" {
  for_each = databricks_sql_query.q_ins_fraud_percent
  query_id    = each.value.id
  type        = "CHART"
  name        = "Fraud"
  description = ""

  // The options encoded in this field are passed verbatim to the SQLA API.
  options = jsonencode(
    {
            "version": 2,
            "globalSeriesType": "column",
            "sortX": true,
            "legend": {
                "enabled": true,
                "placement": "auto",
                "traceorder": "normal"
            },
            "xAxis": {
                "type": "-",
                "labels": {
                    "enabled": true
                },
                "title": {
                    "text": "Fraud Predicted"
                }
            },
            "yAxis": [
                {
                    "type": "linear",
                    "title": {
                        "text": "percent"
                    }
                },
                {
                    "type": "linear",
                    "opposite": true,
                    "title": {
                        "text": null
                    }
                }
            ],
            "alignYAxesAtZero": false,
            "error_y": {
                "type": "data",
                "visible": true
            },
            "series": {
                "stacking": null,
                "error_y": {
                    "type": "data",
                    "visible": true
                }
            },
            "seriesOptions": {
                "count": {
                    "name": "Total"
                }
            },
            "valuesOptions": {},
            "direction": {
                "type": "counterclockwise"
            },
            "sizemode": "diameter",
            "coefficient": 1,
            "numberFormat": "0,0[.]00%",
            "percentFormat": "0[.]00%",
            "textFormat": "",
            "missingValuesAsZero": true,
            "showDataLabels": true,
            "dateTimeFormat": "YYYY-MM-DD HH:mm",
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
            "showPlotlyControls": true,
            "run_as_role": "viewer"
        }
    )
}

resource "databricks_sql_visualization" "q_ins_fraud_hobbies_viz_fraud_pie" {
  for_each = databricks_sql_query.q_ins_fraud_hobbies
  query_id    = each.value.id
  type        = "CHART"
  name        = "Fraud pie"
  description = ""
  options = jsonencode({
                "version": 2,
                "globalSeriesType": "pie",
                "sortX": true,
                "legend": {
                    "enabled": true,
                    "placement": "auto",
                    "traceorder": "normal"
                },
                "xAxis": {
                    "type": "-",
                    "labels": {
                        "enabled": true
                    },
                    "title": {
                        "text": "Insured Hobbies"
                    }
                },
                "yAxis": [
                    {
                        "type": "linear",
                        "title": {
                            "text": "Hobbies Count"
                        }
                    },
                    {
                        "type": "linear",
                        "opposite": true,
                        "title": {
                            "text": null
                        }
                    }
                ],
                "alignYAxesAtZero": false,
                "error_y": {
                    "type": "data",
                    "visible": true
                },
                "series": {
                    "stacking": null,
                    "error_y": {
                        "type": "data",
                        "visible": true
                    }
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
                "valuesOptions": {},
                "direction": {
                    "type": "counterclockwise"
                },
                "sizemode": "diameter",
                "coefficient": 1,
                "numberFormat": "0,0[.]00000",
                "percentFormat": "0[.]00%",
                "textFormat": "",
                "missingValuesAsZero": true,
                "showDataLabels": true,
                "dateTimeFormat": "YYYY-MM-DD HH:mm",
                "columnConfigurationMap": {
                    "x": {
                        "column": "insured_hobbies"
                    },
                    "y": [
                        {
                            "column": "hobbies_count"
                        }
                    ],
                    "series": {
                        "column": null
                    }
                },
                "showPlotlyControls": true,
                "swappedAxes": false
            })
}

resource "databricks_sql_visualization" "q_ins_fraud_hobbies_viz_claim_amount" {
  for_each = databricks_sql_query.q_ins_fraud_hobbies
  query_id    = each.value.id
  type        = "CHART"
  name        = "Claim Amount"
  description = ""
  options = jsonencode({
                "version": 2,
                "globalSeriesType": "column",
                "sortX": true,
                "legend": {
                    "enabled": true,
                    "placement": "auto",
                    "traceorder": "normal"
                },
                "xAxis": {
                    "type": "-",
                    "labels": {
                        "enabled": true
                    },
                    "title": {
                        "text": "Hobbies"
                    }
                },
                "yAxis": [
                    {
                        "type": "linear",
                        "title": {
                            "text": "Total Fraud Claim Amount"
                        }
                    },
                    {
                        "type": "linear",
                        "opposite": true,
                        "title": {
                            "text": "Total Valid Claim Amount"
                        }
                    }
                ],
                "alignYAxesAtZero": false,
                "error_y": {
                    "type": "data",
                    "visible": true
                },
                "series": {
                    "stacking": null,
                    "error_y": {
                        "type": "data",
                        "visible": true
                    }
                },
                "seriesOptions": {
                    "total_claim_amount": {
                        "name": "Total Claim Amount"
                    }
                },
                "valuesOptions": {},
                "direction": {
                    "type": "counterclockwise"
                },
                "sizemode": "diameter",
                "coefficient": 1,
                "numberFormat": "0,0[.]00000",
                "percentFormat": "0[.]00%",
                "textFormat": "",
                "missingValuesAsZero": true,
                "showDataLabels": false,
                "dateTimeFormat": "YYYY-MM-DD HH:mm",
                "columnConfigurationMap": {
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
                    ],
                    "series": {
                        "column": null
                    }
                },
                "showPlotlyControls": true
            })
}

resource "databricks_sql_visualization" "q_ins_fraud_hobbies_viz_weekend" {
  for_each = databricks_sql_query.q_ins_fraud_hobbies
  query_id    = each.value.id
  type        = "CHART"
  name        = "Weekend"
  description = ""
  options = jsonencode({
                "version": 2,
                "globalSeriesType": "column",
                "sortX": true,
                "legend": {
                    "enabled": true,
                    "placement": "auto",
                    "traceorder": "normal"
                },
                "xAxis": {
                    "type": "-",
                    "labels": {
                        "enabled": true
                    },
                    "title": {
                        "text": "Insured Hobbies"
                    }
                },
                "yAxis": [
                    {
                        "type": "linear",
                        "title": {
                            "text": "Weekend Incident"
                        }
                    },
                    {
                        "type": "linear",
                        "opposite": true,
                        "title": {
                            "text": null
                        }
                    }
                ],
                "alignYAxesAtZero": false,
                "error_y": {
                    "type": "data",
                    "visible": true
                },
                "series": {
                    "stacking": null,
                    "error_y": {
                        "type": "data",
                        "visible": true
                    }
                },
                "seriesOptions": {},
                "valuesOptions": {},
                "direction": {
                    "type": "counterclockwise"
                },
                "sizemode": "diameter",
                "coefficient": 1,
                "numberFormat": "0,0[.]00000",
                "percentFormat": "0[.]00%",
                "textFormat": "",
                "missingValuesAsZero": true,
                "showDataLabels": false,
                "dateTimeFormat": "YYYY-MM-DD HH:mm",
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
                "showPlotlyControls": true
            })
}
