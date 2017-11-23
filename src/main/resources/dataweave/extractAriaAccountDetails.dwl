%dw 1.0
%output application/java
%namespace env http://schemas.xmlsoap.org/soap/envelope/
%namespace aria urn:client:api:wsdl:document/literal_wrapped:vers:11.0:aria_complete_m_api
%var responseElement = payload.env#Envelope.env#Body.aria#get_acct_details_all_mResponseElement
%var masterPlanInfo = responseElement.*master_plans_info[?($.master_plan_instance_no == flowVars.event.account.clientPlanInstanceId)][0]
%function getValue  (field) (field.plan_instance_field_value[0] when field != null otherwise null)
%function getValueString  (field) (field.plan_instance_field_value[0] when field != null otherwise "")

---
{
  errorMsg: responseElement.error_msg,
  errorCode: responseElement.error_code,
  accountNumber: responseElement.acct_no,
  currencyCode: responseElement.acct_currency,

	//customerAddressId:  getValue(responseElement.*master_plans_info[?( $.client_master_plan_instance_id == flowVars.event.account.clientPlanInstanceId ) ][0].*mp_plan_inst_fields[?( $.plan_instance_field_name == 'BILL_TO_ADDRESS_IDS' ) ]),   
	customerAddressId:  getValue(masterPlanInfo.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'BILL_TO_ADDRESS_IDS' ) ]),   
    
  planInstanceNumber: masterPlanInfo.master_plan_instance_no,
  purchaseOrderNumber: masterPlanInfo.po_num,
  sfdcProjectId: getValue(masterPlanInfo.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'SALESFORCE_PROJECT_ID' ) ]),

  sfdcProjectName: getValue(masterPlanInfo.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'SALESFORCE_PROJECT_NAME' ) ]),
  projectCreationDate: getValue(masterPlanInfo.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'PROJECT_CREATION_DATE' ) ]),
  operatingUnitName: getValue(masterPlanInfo.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'OPERATING_UNIT_NAME' ) ]),
  businessUnit: upper getValue(masterPlanInfo.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'BUSINESS_UNIT' ) ]),
  revenueSite: getValue(masterPlanInfo.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'REVENUE_SITE' ) ]),
  primaryServiceSite: getValue(masterPlanInfo.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'PRIMARY_SERVICE_SITE' ) ]),
  salesRepSplitAmountString: upper getValueString(masterPlanInfo.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'SALESREP_SPLIT_AMOUNT' ) ]),
  // EmpName|empId|PRimary|Percent;EmpName|empId|PRimary|Percent;EmpName|empId|PRimary|Percent

splitBillingAccounts: null when masterPlanInfo.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'SPLIT_BILLING_ACCOUNTS' ) ] == null 
  otherwise
    ((masterPlanInfo.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'SPLIT_BILLING_ACCOUNTS' ) ].plan_instance_field_value[0]
 		splitBy ";") map using (line = $ splitBy "|") {
     acctId: line[0],
     splitPercentage: line[1]
 }) when ((sizeOf (trim masterPlanInfo.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'SPLIT_BILLING_ACCOUNTS' ) ].plan_instance_field_value[0])) > 2) otherwise null,


 //splitBillingAccounts: null when responseElement.master_plans_info.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'SPLIT_BILLING_ACCOUNTS' ) ] == null 
 // otherwise
 //   ((responseElement.master_plans_info.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'SPLIT_BILLING_ACCOUNTS' ) ].plan_instance_field_value[0]
 //		splitBy ";") map using (line = $ splitBy "|") {
  //   acctId: line[0],
  //   splitPercentage: line[1]
 //}) when (sizeOf (trim responseElement.master_plans_info.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'SPLIT_BILLING_ACCOUNTS' ) ].plan_instance_field_value[0]) > 2) otherwise null,

  productType: getValue(masterPlanInfo.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'PRODUCT_TYPE' ) ]),
  countryOfIssuer: getValue(masterPlanInfo.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'COUNTRY_OF_ISSUER' ) ]),
  contractTerm: getValue(masterPlanInfo.*mp_plan_inst_fields[?( $.plan_instance_field_name == 'CONTRACT_TERM' ) ]),
  clientServiceLocationId: masterPlanInfo.master_plans_services.client_svc_location_id,
  serviceNumber: masterPlanInfo.master_plans_services.service_no,
  //serviceNumber1: masterPlanInfo.master_plans_services.service_no,
  shipFromLocation: masterPlanInfo.*supp_plans_info[0].supp_plans_services.svc_location_no
  
  
	
}