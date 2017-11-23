%dw 1.0
%output application/json
---
{
  "CREATE_INVOICE_Input": { 
    "InputParameters": {
      "P_INVOICE": {
        "SOURCE_SYSTEM": "XXARIA",
        "SOURCE_INVOICE_NUMBER": flowVars.event.financialTransaction.financialTransGranularId,
        ("PARENT_SOURCE_INVOICE_NUMBER":flowVars.invoiceDetailsSummary.originalInvoiceNumber) when flowVars.invoiceDetailsSummary.originalInvoiceNumber != null,
        "PROJECT_SOURCE_SYSTEM": "XXSF",
        "SOURCE_PROJECT_NUMBER": flowVars.ariaAccountDetails.sfdcProjectId,//flowVars.SFProjectNumber, 
        "INVOICE_DESCRIPTION": flowVars.ariaAccountDetails.sfdcProjectName,
        "INVOICE_DATE": flowVars.event.financialTransaction.financialTransDate,
        "CONTACT": trim ( (flowVars.ariaAccountContacts.firstName default "") ++ " " ++ (flowVars.ariaAccountContacts.lastName default "") ),
		"INVOICE_RECIPIENTS": flowVars.ariaAccountContacts.email,
        "CUSTOMER_ADDRESS_ID": flowVars.ariaAccountDetails.customerAddressId, //OraSite,
        "CURRENCY_CODE": upper flowVars.ariaAccountDetails.currencyCode,
        "COUNTRY_OF_ISSUER": flowVars.ariaAccountDetails.countryOfIssuer,
        "CONTRACT_TERM": flowVars.ariaAccountDetails.contractTerm,
        "CUSTOMER_ORDER_NUMBER": flowVars.ariaAccountDetails.purchaseOrderNumber, // get the first po_num
        "INVOICE_SELL_TOTAL": flowVars.invoiceDetailsSummary.invoiceSellTotal as :string,
        "INVOICE_LINE_COUNT": flowVars.invoiceDetailsSummary.invoiceLineCount as :string,

		"SALESREPS": {
			"SALESREPS_ITEM": flowVars.SalesRepInfo map ((repItem,repItemIndex) -> {
				"SALESREP_ID": "$(repItem.salesRepresentativeId)",  //need to call lookup table with the whole string and operatingUnitName 
				"SPLIT_PERCENTAGE": "$(repItem.percent)",
				"PRIMARY": repItem.primary //"Y" when repItem.isPrimary otherwise "N"
			})
		},


         "SPLIT_BILLING": {
          ("SPLIT_BILLING_ITEM": flowVars.splitBilling map {
				"CUSTOMER_ADDRESS_ID": $.oracleId,  // need to get from MDR ORGADDR
				"SPLIT_PERCENTAGE": $.billingSplit
			}) when flowVars.splitBilling != null
        },
        "LINES": {
          "LINES_ITEM": flowVars.lineDetails  map  ((lineItem,lineItemIndex) -> {
			"SOURCE_LINE_ID": lineItem.invoiceTransactionId, //old one: sourceLineId,
			"PROJECT_SOURCE_SYSTEM": "XXSF",
			"SOURCE_PROJECT_NUMBER": flowVars.ariaAccountDetails.sfdcProjectId,//flowVars.SFProjectNumber, 
			"SOURCE_ITEM": lineItem.creditCouponCode when (lineItem.lineType == '4') otherwise lineItem.creditReasonCodeDesc when (lineItem.lineType == '3') otherwise lineItem.serviceName,
			"EXPENDITURE_ORG_ID": flowVars.ExpOrgId , // from Mapping  businessUnit, primaryServiceSite, "DATASITE"
			"PRODUCT_TYPE": flowVars.ariaAccountDetails.productType,
			"UNIT_RATE": lineItem.unitRate,
			"QUANTITY": lineItem.quantity,
			"SELL_AMOUNT": lineItem.sellAmount,
			"ITEM_DESCRIPTION": lineItem.itemDescription,
			"BILL_TO_CONTACT_NAME":  trim ( (flowVars.ariaAccountContacts.firstName default "") ++ " " ++ (flowVars.ariaAccountContacts.lastName default "") ),
			(using (acctContacts=lookup("GET_ARIA_ACCOUNT_CONTACTS",lineItem.shipToAddress)) 
				"SHIP_TO_CONTACT_NAME":  trim ( (acctContacts.firstName default "") ++ " " ++ (acctContacts.lastName default "") )),
			
			
			"PRODUCTION_DATE_RECEIVED": flowVars.event.financialTransaction.financialTransDate when lineItem.orderNumber == null 
			                 otherwise lookup('getOrder_Flow', { accountNumber: flowVars.event.account.accountNumber , orderNumber: lineItem.orderNumber }).createDate,
			                 //"createDate from getOrder",  //"datefromOrder"
			
              "DISTRIBUTIONS": {
                "DISTRIBUTIONS_ITEM": [
                  {
                    "DIST_LINE_NUMBER":  "1",
                    "DISTRIBUTION_QTY": lineItem.quantity,
                    "SHIP_DATE": flowVars.event.financialTransaction.financialTransDate, // date from order
                    "LOCATIONS": {
                      "LOCATIONS_ITEM": [
                        (using (clientServiceLocationId=lookup('aria_getClientServiceLocationId_Flow', { accountDetails: flowVars.ariaAccountDetailsRawXml,  clientMasterPlanInstanceId: flowVars.event.account.clientPlanInstanceId, clientPlanInstanceId: lineItem.clientPlanInstanceId, serviceNumber: lineItem.serviceNumber })){
                           "LOCATION_TYPE": "SHIP_FROM",
                          "SERVICE_LOCATION": clientServiceLocationId,
                          "CONTACT_NAME": clientServiceLocationId,
                          "COMPANY_NAME": clientServiceLocationId                      	
                        })  when (lineItem.orderNumber == null),
                        (using (orderDetails=lookup('getOrder_Flow', { accountNumber: flowVars.event.account.accountNumber , orderNumber: lineItem.orderNumber })){
                          "LOCATION_TYPE": "SHIP_FROM",
                          "SERVICE_LOCATION": orderDetails.clientItemServiceLocationId,
                          "CONTACT_NAME": orderDetails.clientItemServiceLocationId,
                          "COMPANY_NAME": orderDetails.clientItemServiceLocationId                     	
                        })  when (lineItem.orderNumber != null),
                        {
                          "LOCATION_TYPE": "ADMIN_DEST",
                          "CUSTOMER_ADDRESS_ID": flowVars.ariaAccountDetails.customerAddressId, //OraSite,
                          "CONTACT_NAME": ""
                        },                        
                        (using (acctContacts=lookup("GET_ARIA_ACCOUNT_CONTACTS",lineItem.shipToAddress)){                          
                          "LOCATION_TYPE": "SHIP_TO",
                          "CUSTOMER_ADDRESS_ID": "" ,
                          "CONTACT_NAME":   trim ( (acctContacts.firstName default "") ++ " " ++ (acctContacts.lastName default "") ),

						  "COMPANY_NAME": acctContacts.companyName default "NULL",
                          "ADDRESS1": acctContacts.address1,
                          "ADDRESS2": acctContacts.address2,
                          "ADDRESS3": acctContacts.address3,
                          "ADDRESS4": "",
                          "CITY": acctContacts.city ,
                          "COUNTY": "",
                          "STATE": acctContacts.stateProvince,
                          "POSTAL_CODE": acctContacts.postal,
                          "PROVINCE": "",
                          "COUNTRY": acctContacts.country                         
                        }) when lineItem.orderNumber != null,
                        
                        (using (acctContacts=lookup("GET_ARIA_ACCOUNT_CONTACTS",lineItem.shipToAddress)){    
                          "LOCATION_TYPE": "SHIP_TO",
                          "CUSTOMER_ADDRESS_ID": flowVars.ariaAccountDetails.customerAddressId, //OraSite 
                          "CONTACT_NAME":    trim ( (acctContacts.firstName default "") ++ " " ++ (acctContacts.lastName default "") )  
                        })  when lineItem.orderNumber == null
                      ]
                    },
                    "TAX_DETAILS": {
                      "TAX_DETAILS_ITEM":  flowVars.taxes.taxDetails filter ($.taxedSeqNum == lineItem.sourceLineId) map {
                      	  "SITUS": "DESTINATION", 
                          "JURISDICTION_LEVEL": flowVars.jurisdictionTable[$.jurisdictionLevel],
                          "JURISDICTION_VALUE": $.jurisdictionValue,
                          "TAX_AMOUNT": $.taxAmount,
                          "TAX_RATE": $.taxRate,
                          "TAXABLE_AMOUNT": lineItem.sellAmount,
                          "TAX_TYPE": "SALES" // $.taxServiceTypeId
                      }
                    }
                  }
                ]
              } when flowVars.taxes.taxDetails.*taxedSeqNum contains lineItem.lineNumber otherwise {}
            }
            
            )
          
        }
      }
    }
  }
}