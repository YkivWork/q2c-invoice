%dw 1.0
%output application/java
%namespace env http://schemas.xmlsoap.org/soap/envelope/
%namespace aria urn:client:api:wsdl:document/literal_wrapped:vers:11.0:aria_complete_m_api
%var responseElement = payload.env#Envelope.env#Body.aria#get_invoice_details_mResponseElement
---
{

 taxDetails: responseElement.*tax_details  map {
		taxDetailLine: $.tax_detail_line,
		taxedSeqNum: $.taxed_seq_num,
		jurisdictionLevel: $.tax_authority_level as :number,
		jurisdictionValue: $.tax_srv_juris_nm,
		taxAmount: $.debit,
		taxRate: $.tax_rate,
		taxableAmount: $.debit,
		taxServiceTypeId: $.tax_srv_tax_type_id,
		taxServiceTypeDescription: $.tax_srv_tax_type_desc 
     
	} 
}