%dw 1.0
%output application/java
---
{
	eventId: payload.apf2doc.event_data.event.event_id,
	eventLabel: payload.apf2doc.event_data.event.event_label,
	request: {
		version: payload.apf2doc.request.version,
		sender: payload.apf2doc.request.sender,
		transactionId: payload.apf2doc.request.transaction_id,
		action: payload.apf2doc.request.action,
		class: payload.apf2doc.request.class
	},
	account: {
		clientNumber: payload.apf2doc.account.client_no,
		accountNumber: payload.apf2doc.account.acct_no,
		userId: payload.apf2doc.account.userid,
		planInstanceNumber: payload.apf2doc.account.master_plan_instances.master_plan_instance_data.plan_instance_no,
		clientPlanInstanceId: payload.apf2doc.account.master_plan_instances.master_plan_instance_data.client_plan_instance_id,
		respLevelCd: payload.apf2doc.account.master_plan_instances.master_plan_instance_data.resp_level_cd
	},
	financialTransactionGroup: {
		objectType: payload.apf2doc.financial_transaction_groups.financial_transaction_group.Object_type,
		objectNumber: payload.apf2doc.financial_transaction_groups.financial_transaction_group.Object_no,
		billingGroupNumber: payload.apf2doc.financial_transaction_groups.financial_transaction_group.billing_group_no,
		billingGroupName: payload.apf2doc.financial_transaction_groups.financial_transaction_group.billing_group_name,
		clientBillingGroupId: payload.apf2doc.financial_transaction_groups.financial_transaction_group.client_billing_group_id,
		totalAmount: payload.apf2doc.financial_transaction_groups.financial_transaction_group.total_amount		
	},
	financialTransaction: {
		transId: payload.apf2doc.financial_transactions.financial_transaction.financial_trans_id,
		financialTransGranularId: payload.apf2doc.financial_transactions.financial_transaction.financial_trans_granular_id,
		financialTransTypeNo: payload.apf2doc.financial_transactions.financial_transaction.financial_trans_type_no,
		financialTransTypeLabel: payload.apf2doc.financial_transactions.financial_transaction.financial_trans_type_label,
		financialTransDate: convertFromAriaDateToOracle(payload.apf2doc.financial_transactions.financial_transaction.financial_trans_date),
		transactionAmount: payload.apf2doc.financial_transactions.financial_transaction.financial_trans_amount,
		financialTransInvType: payload.apf2doc.financial_transactions.financial_transaction.financial_trans_inv_type_cd
	}
}