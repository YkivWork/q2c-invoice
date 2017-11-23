%dw 1.0
%output application/xml
%namespace lit urn:client:api:wsdl:document/literal_wrapped:vers:11.0:aria_complete_m_api
%namespace soap http://schemas.xmlsoap.org/soap/envelope/
---
{
  soap#Envelope: {
    soap#Header: {},
    soap#Body: {
      lit#get_order_m: {
        client_no: p('aria.client_no'),
        auth_key: p('aria.auth_key'),
        details_flag: 1,
        acct_no: payload.accountNumber, //"1619508", //payload.accountNumber,//flowVars.account.accountNumber
		order_no: payload.orderNumber //"430287"//payload.orderNumber  // where is this from?
      }
    }
  }
}