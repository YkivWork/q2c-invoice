package com.merrillcorp.integration.scatter;

import java.util.List;
import java.util.Set;

import org.mule.api.MuleEvent;
import org.mule.api.MuleException;
import org.mule.api.routing.AggregationContext;
import org.mule.routing.CollectAllAggregationStrategy;

public class CustomAggregationStrategy extends CollectAllAggregationStrategy {
public MuleEvent aggregate(AggregationContext context) throws MuleException {
        
        MuleEvent event = super.aggregate(context);
        
        List<MuleEvent> lstEvents = context.getEvents();
        for (MuleEvent muleEvent : lstEvents) {
            Set<String> fnames = muleEvent.getFlowVariableNames();
            for (String flowVar : fnames) {
                // All flow variables with same key names in individual flow responses will get overriden with next value.
                // Please make sure the flow variables names are unique in scatter-gather.
                event.setFlowVariable(flowVar, muleEvent.getFlowVariable(flowVar), muleEvent.getFlowVariableDataType(flowVar));
            }
        }
        
        return event;
    }
	
}