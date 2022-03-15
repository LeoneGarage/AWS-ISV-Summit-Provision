
resource "databricks_sql_visualization" "q_ins_fraud_by_severity_viz_pie" {
  query_id    = databricks_sql_query.q_ins_fraud_by_severity.id
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
                "text": "incident_severity"
            }
        },
        "yAxis": [
            {
                "type": "linear",
                "title": {
                    "text": "fraud_predicted"
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
  query_id    = databricks_sql_query.q_ins_fraud_by_severity.id
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
                        "text": "insured_hobbies"
                    }
                },
                "yAxis": [
                    {
                        "type": "linear",
                        "title": {
                            "text": "fraud_incident_weekend_flag"
                        }
                    },
                    {
                        "type": "linear",
                        "opposite": true,
                        "title": {
                            "text": "valid_incident_weekend_flag"
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
  query_id    = databricks_sql_query.q_ins_fraud_by_severity.id
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
                            "text": "fraud_predicted"
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
  query_id    = databricks_sql_query.q_ins_fraud_fitted.id
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
  query_id    = databricks_sql_query.q_ins_fraud_percent.id
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
            "showPlotlyControls": true
        }
    )
}

resource "databricks_sql_visualization" "q_ins_fraud_hobbies_viz_fraud_pie" {
  query_id    = databricks_sql_query.q_ins_fraud_hobbies.id
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
                        "text": "insured_hobbies"
                    }
                },
                "yAxis": [
                    {
                        "type": "linear",
                        "title": {
                            "text": "hobbies_count"
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
  query_id    = databricks_sql_query.q_ins_fraud_hobbies.id
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
                            "text": "total_fraud_claim_amount"
                        }
                    },
                    {
                        "type": "linear",
                        "opposite": true,
                        "title": {
                            "text": "total_valid_claim_amount"
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
  query_id    = databricks_sql_query.q_ins_fraud_hobbies.id
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
                        "text": "insured_hobbies"
                    }
                },
                "yAxis": [
                    {
                        "type": "linear",
                        "title": {
                            "text": "incident_weekend_flag"
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
