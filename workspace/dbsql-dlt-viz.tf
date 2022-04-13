resource "databricks_sql_visualization" "q_ins_claims_by_city_viz_pie" {
  for_each = databricks_sql_query.q_ins_claims_by_city
  lifecycle {
    ignore_changes = [
        options
    ]
  }
  query_id    = each.value.id
  type        = "CHART"
  name        = "Claim Amount Ratios By City"
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
                "text": "Incident City"
            }
        },
        "yAxis": [
            {
                "type": "linear",
                "title": {
                    "text": "Claim Amount Ratios"
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
                "name": "Claim Amount Ratios"
            },
            "claim_amount": {
                            "name": "Claim Amount Ratios"
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
                "column": "incident_city"
            },
            "y": [
                {
                    "column": "claim_amount"
                }
            ],
            "series": {
                "column": null
            }
        },
        "showPlotlyControls": true,
        "swappedAxes": false
    }
    # {
    #     "alignYAxesAtZero": false,
    #     "coefficient": 1,
    #     "columnConfigurationMap": {
    #         "x": {
    #             "column": "incident_city",
    #             "id": "column_efa9485d5723"
    #         },
    #         "y": [
    #             {
    #                 "column": "claim_amount",
    #                 "id": "column_efa9485d5722",
    #                 "transform": "SUM"
    #             }
    #         ]
    #     },
    #     "dateTimeFormat": "YYYY-MM-DD HH:mm",
    #     "direction": {
    #         "type": "counterclockwise"
    #     },
    #     "error_y": {
    #         "type": "data",
    #         "visible": true
    #     },
    #     "globalSeriesType": "pie",
    #     "legend": {
    #         "traceorder": "normal"
    #     },
    #     "missingValuesAsZero": true,
    #     "numberFormat": "0,0[.]00000",
    #     "percentFormat": "0[.]00%",
    #     "series": {
    #         "error_y": {
    #             "type": "data",
    #             "visible": true
    #         },
    #         "stacking": null
    #     },
    #     "seriesOptions": {
    #         "column_efa9485d5722": {
    #             "name": "Claim Amount",
    #             "type": "pie",
    #             "yAxis": 0
    #         }
    #     },
    #     "showDataLabels": true,
    #     "sizemode": "diameter",
    #     "sortX": true,
    #     "sortY": true,
    #     "swappedAxes": false,
    #     "textFormat": "",
    #     "useAggregationsUi": true,
    #     "valuesOptions": {},
    #     "version": 2,
    #     "xAxis": {
    #         "labels": {
    #             "enabled": true
    #         },
    #         "type": "-"
    #     },
    #     "yAxis": [
    #         {
    #             "type": "-"
    #         },
    #         {
    #             "opposite": true,
    #             "type": "-"
    #         }
    #     ]
    # }
  )
}

resource "databricks_sql_visualization" "q_ins_claims_by_hobbies_viz_pie" {
  for_each = databricks_sql_query.q_ins_claims_by_hobbies
  lifecycle {
    ignore_changes = [
        options
    ]
  }
  query_id    = each.value.id
  type        = "CHART"
  name        = "Claim Amount Ratios By Hobbies"
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
                "text": "Insured Hobbies"
            }
        },
        "yAxis": [
            {
                "type": "linear",
                "title": {
                    "text": "Claim Amount Ratios"
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
                "name": "Claim Amount Ratios"
            },
            "claim_amount": {
                            "name": "Claim Amount Ratios"
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
                    "column": "claim_amount"
                }
            ],
            "series": {
                "column": null
            }
        },
        "showPlotlyControls": true,
        "swappedAxes": false
    }
    # {
    #     "alignYAxesAtZero": false,
    #     "coefficient": 1,
    #     "columnConfigurationMap": {
    #         "x": {
    #             "column": "insured_hobbies",
    #             "id": "column_efa9485d8309"
    #         },
    #         "y": [
    #             {
    #                 "column": "claim_amount",
    #                 "id": "column_efa9485d8308",
    #                 "transform": "SUM"
    #             }
    #         ]
    #     },
    #     "dateTimeFormat": "YYYY-MM-DD HH:mm",
    #     "direction": {
    #         "type": "counterclockwise"
    #     },
    #     "error_y": {
    #         "type": "data",
    #         "visible": true
    #     },
    #     "globalSeriesType": "pie",
    #     "legend": {
    #         "traceorder": "normal"
    #     },
    #     "missingValuesAsZero": true,
    #     "numberFormat": "0,0[.]00000",
    #     "percentFormat": "0[.]00%",
    #     "series": {
    #         "error_y": {
    #             "type": "data",
    #             "visible": true
    #         },
    #         "stacking": null
    #     },
    #     "seriesOptions": {
    #         "column_efa9485d8308": {
    #             "name": "Claim Amount",
    #             "type": "pie",
    #             "yAxis": 0
    #         }
    #     },
    #     "showDataLabels": true,
    #     "sizemode": "diameter",
    #     "sortX": true,
    #     "sortY": true,
    #     "swappedAxes": false,
    #     "textFormat": "",
    #     "useAggregationsUi": true,
    #     "valuesOptions": {},
    #     "version": 2,
    #     "xAxis": {
    #         "labels": {
    #             "enabled": true
    #         },
    #         "type": "-"
    #     },
    #     "yAxis": [
    #         {
    #             "type": "-"
    #         },
    #         {
    #             "opposite": true,
    #             "type": "-"
    #         }
    #     ]
    # }
  )
}

resource "databricks_sql_visualization" "q_ins_claims_by_auto_type_viz_pie" {
  for_each = databricks_sql_query.q_ins_claims_by_auto_type
  lifecycle {
    ignore_changes = [
        options
    ]
  }
  query_id    = each.value.id
  type        = "CHART"
  name        = "Claim Amount Ratios By Auto type"
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
                "text": "Auto Type"
            }
        },
        "yAxis": [
            {
                "type": "linear",
                "title": {
                    "text": "Claim Amount Ratios"
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
                "name": "Claim Amount Ratios"
            },
            "claim_amount": {
                            "name": "Claim Amount Ratios"
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
                "column": "auto_type"
            },
            "y": [
                {
                    "column": "claim_amount"
                }
            ],
            "series": {
                "column": null
            }
        },
        "showPlotlyControls": true,
        "swappedAxes": false
    }
    # {
    #     "alignYAxesAtZero": false,
    #     "coefficient": 1,
    #     "columnConfigurationMap": {
    #         "x": {
    #             "column": "auto_type",
    #             "id": "column_efa9485d16101"
    #         },
    #         "y": [
    #             {
    #                 "column": "claim_amount",
    #                 "id": "column_efa9485d11801",
    #                 "transform": "SUM"
    #             }
    #         ]
    #     },
    #     "dateTimeFormat": "YYYY-MM-DD HH:mm",
    #     "direction": {
    #         "type": "counterclockwise"
    #     },
    #     "error_y": {
    #         "type": "data",
    #         "visible": true
    #     },
    #     "globalSeriesType": "pie",
    #     "legend": {
    #         "traceorder": "normal"
    #     },
    #     "missingValuesAsZero": true,
    #     "numberFormat": "0,0[.]00000",
    #     "percentFormat": "0[.]00%",
    #     "series": {
    #         "error_y": {
    #             "type": "data",
    #             "visible": true
    #         },
    #         "stacking": "stack"
    #     },
    #     "seriesOptions": {
    #         "column_efa9485d11801": {
    #             "name": "Claim Amount",
    #             "type": "pie",
    #             "yAxis": 0
    #         }
    #     },
    #     "showDataLabels": true,
    #     "sizemode": "diameter",
    #     "sortX": true,
    #     "sortY": true,
    #     "swappedAxes": false,
    #     "textFormat": "",
    #     "useAggregationsUi": true,
    #     "valuesOptions": {},
    #     "version": 2,
    #     "xAxis": {
    #         "labels": {
    #             "enabled": true
    #         },
    #         "type": "-"
    #     },
    #     "yAxis": [
    #         {
    #             "type": "-"
    #         },
    #         {
    #             "opposite": true,
    #             "type": "-"
    #         }
    #     ]
    # }
  )
}