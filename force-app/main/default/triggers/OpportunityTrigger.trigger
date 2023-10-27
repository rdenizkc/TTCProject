trigger OpportunityTrigger on Opportunity ( after update) {
    
    
    if(trigger.isAfter){
        if(  trigger.isUpdate){
            OpportunityTriggerHandler.createTaskForClosedWonOpp(Trigger.new, Trigger.oldMap);
            
        }
    }
}