%dw 1.0
%output application/java
---
{
	invoiceSellTotal: sum flowVars.invoiceDetailsTemp.invoiceLineDetails.amount,
	invoiceLineCount: sizeOf flowVars.invoiceDetailsTemp.invoiceLineDetails, 
	originalInvoiceNumber: flowVars.invoiceDetailsTemp.originalInvoiceNumber,
	lines: flowVars.invoiceDetailsTemp.invoiceLineDetails map {

		sourceLineId: $.line_no,
		serviceNumber: $.service_no,
		serviceName: $.service_name,		 
		lineNumber: $.line_no,
		lineType: $.line_type,
		quantity: $.units,
		unitRate: $.rate_per_unit default 1.0,
		sellAmount: $.amount,
		itemDescription: $.description,
		billToAddress: $.bill_to_address_seq,
		shipToAddress: $.ship_to_address_seq,
		orderNumber: $.order_no,
		invoiceTransactionId: $.invoice_transaction_id,
		originalInvoiceNumber: $.orig_invoice_no,
		clientPlanInstanceId: $.client_plan_instance_id,
		shipFromLocation: $.ship_from_location_no,
		creditCouponCode: $.credit_coupon_code,
		creditReasonCodeDesc: $.credit_reason_code_description,
		serviceCreditAppliedLineNumber: $.svc_credit_applied_line_no
	}

}