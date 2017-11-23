%dw 1.0
%output application/java
%namespace env http://schemas.xmlsoap.org/soap/envelope/
%namespace aria urn:client:api:wsdl:document/literal_wrapped:vers:11.0:aria_complete_m_api
%var responseElement = payload.env#Envelope.env#Body.aria#get_acct_details_all_mResponseElement
%function getValue  (field) (field.plan_instance_field_value[0] when field != null otherwise null)
%function getValueString  (field) (field.plan_instance_field_value[0] when field != null otherwise "")

---
 getValue(responseElement.*master_plans_info[?( $.client_master_plan_instance_id == flowVars.event.account.clientPlanInstanceId ) ][0].*mp_plan_inst_fields[?( $.plan_instance_field_name == 'BILL_TO_ADDRESS_IDS' ) ])

