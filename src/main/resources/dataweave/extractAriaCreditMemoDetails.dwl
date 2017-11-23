%dw 1.0
%output application/java
%namespace env http://schemas.xmlsoap.org/soap/envelope/
%namespace aria urn:client:api:wsdl:document/literal_wrapped:vers:11.0:aria_complete_m_api
%var responseElement = payload.env#Envelope.env#Body.aria#get_cm_details_mResponseElement
---
{
  errorMsg: responseElement.error_msg,
  errorCode: responseElement.error_code,
  
  originalInvoiceNumber: responseElement.orig_invoice_no
 

 
	
}