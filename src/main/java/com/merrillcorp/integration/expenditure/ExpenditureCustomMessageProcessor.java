package com.merrillcorp.integration.expenditure;

import java.util.List;

import org.mule.api.MuleEvent;
import org.mule.api.MuleException;
import org.mule.api.MuleMessage;
import org.mule.modules.objectstore.ObjectStoreConnector;
import org.mule.processor.AbstractInterceptingMessageProcessorBase;

/**
 * 
 * @author bkalali
 *
 */
public class ExpenditureCustomMessageProcessor extends AbstractInterceptingMessageProcessorBase {

	@Override
	@SuppressWarnings("unchecked")
	public MuleEvent process(MuleEvent event) throws MuleException {
		MuleMessage muleMessage = event.getMessage();
		String businessUnit = event.getFlowVariable("businessUnit");
		String serviceSite = event.getFlowVariable("serviceSite");
		String teamType = event.getFlowVariable("teamType");
		String expenditureKeyInObjectStore = event.getFlowVariable("expenditureKey");
		ExpenditureKey requestedExpenditureKey = new ExpenditureKey(businessUnit, serviceSite, teamType);
		List<ExpenditureKey> expenditureKeys = (List<com.merrillcorp.integration.expenditure.ExpenditureKey>) muleMessage
				.getPayload();
		ExpenditureKey foundTheExpenditureKey = null;
		for (ExpenditureKey expenditureKey : expenditureKeys) {
			if (expenditureKey.equals(requestedExpenditureKey)) {
				foundTheExpenditureKey = expenditureKey;
			}
		}
		if (foundTheExpenditureKey != null) {
			muleMessage.setPayload(foundTheExpenditureKey.getExpenditureId());
		} else {
			ObjectStoreConnector obj = event.getMuleContext().getRegistry()
					.lookupObject("nonPersistentObjectStoreConfig");
			obj.remove(expenditureKeyInObjectStore, true);
			event.getMessage().setPayload("none");
		}
		return event;
	}

}