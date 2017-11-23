{ 
  "CREATE_INVOICE_Input": { 
    "@xmlns": "http://fin-dev-www-2.adminsys.mrll.com:8005/webservices/rest/xxbs_invoice_svc/create_invoice", 
    "RESTHeader": { 
      "@xmlns": "http://fin-dev-www-2.adminsys.mrll.com:8005/webservices/rest/xxbs_invoice_svc/header",
      "Responsibility": "XXPA_MANAGER",
      "RespApplication": "PA",
      "SecurityGroup": "STANDARD",
      "NLSLanguage": "AMERICAN",
      "Org_Id": "21"    }, 
    "InputParameters": { 
      "P_INVOICE": { 
        "SOURCE_SYSTEM": "XXARIA", 
        "SOURCE_INVOICE_NUMBER": "lmtest-1", 
        "SOURCE_PROJECT_NUMBER": "lmtest-1",
        "INVOICE_DESCRIPTION": "lmtest-1 DESC",
        "INVOICE_DATE": "2017-01-01",
        "CONTACT": "CONTACT",
        "CUSTOMER_ADDRESS_ID": "28175",
        "CURRENCY_CODE": "USD",
        "COUNTRY_OF_ISSUER": "US",
        "CONTRACT_TERM": "60",
        "SALESREPS": {
           "SALESREPS_ITEM": [
             {"SALESREP_ID": "100000054", 
                "SPLIT_PERCENTAGE": "50", 
                "PRIMARY": "Y"},
             {"SALESREP_ID": "100000054", 
                "SPLIT_PERCENTAGE": "50", 
                "PRIMARY": "Y"} ]
        },
        "SPLIT_BILLING": { 
          "SPLIT_BILLING_ITEM": [
            {"CUSTOMER_ADDRESS_ID": "10664", 
              "SPLIT_PERCENTAGE": "100"} ]
        },
        "LINES": { 
           "LINES_ITEM": [ 
               {"SOURCE_LINE_ID": "1", 
                "SOURCE_PROJECT_NUMBER": "AKTEST-2", 
                "SOURCE_ITEM": "HOST MB",
                "EXPENDITURE_ORG_ID": "2417",
                "PRODUCT_TYPE": "DATASITE-ASSET SALE",
                "UNIT_RATE": ".05",
                "QUANTITY": "100",
                "PRODUCTION_DATE_RECEIVED": "2017-04-05",
                
                "DISTRIBUTIONS": { 
                    "DISTRIBUTIONS_ITEM": [ 
                       {"DIST_LINE_NUMBER": "1", 
                        "DISTRIBUTION_QTY": "100", 
                        "SHIP_DATE": "2017-04-05", 
                        "LOCATIONS": { 
                            "LOCATIONS_ITEM": [ 
                                {"LOCATION_TYPE": "SHIP_FROM", 
                                "CUSTOMER_ADDRESS_ID": "28175", 
                                "CONTACT_NAME": ""
                                },
                                {"LOCATION_TYPE": "ADMIN_DEST", 
                                "CUSTOMER_ADDRESS_ID": "28175", 
                                "CONTACT_NAME": ""
                                },
                                { "LOCATION_TYPE": "SHIP_TO", 
                                "CUSTOMER_ADDRESS_ID": "28175", 
                                "CONTACT_NAME": ""} ] 
                        }, 
                        "TAX_DETAILS": { 
                            "TAX_DETAILS_ITEM": [
                                {"SITUS": "DESTINATION", 
                                "JURISDICTION_LEVEL": "STATE", 
                                "JURISDICTION_VALUE": "CALIFORNIA",
                                "TAX_AMOUNT": "5", 
                                "TAX_RATE": ".05", 
                                "TAXABLE_AMOUNT": "0",
                                "TAX_TYPE": "SALES"} ]
                          } 
                     } ]
                }
            } ]
        }
      }      
    }
  }
}
