%dw 1.0
%output application/java
%namespace env http://schemas.xmlsoap.org/soap/envelope/
%namespace aria urn:client:api:wsdl:document/literal_wrapped:vers:11.0:aria_complete_m_api
%var responseElement = payload.env#Envelope.env#Body.aria#get_invoice_details_mResponseElement
---
{
  errorMsg: responseElement.error_msg,
  errorCode: responseElement.error_code,
  
  serviceNumber: responseElement.invoice_line_details.service_no,
  serviceName: responseElement.invoice_line_details.service_name,
  quantity: responseElement.invoice_line_details.units,
  unitRate: responseElement.invoice_line_details.rate_per_unit,
  sellAmount: responseElement.invoice_line_details.amount,
  itemDescription: responseElement.invoice_line_details.description, 
  

 
	
}