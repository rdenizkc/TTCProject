public class OpportunityTriggerHandlerL {
    public static void OppClosedWonTask(List<Opportunity> newOpp, Map<Id, Opportunity>oldOpp){
        List<Task> newTasks = new List<Task>();
        for (Opportunity opp: newOpp){
            if(opp.StageName=='Closed Won'&& oldOpp.get(opp.Id).StageName != 'Closed Won'){
                Task oppTask =new Task();
                
                oppTask.Subject= 'Follow up Task';
                oppTask.ActivityDate=opp.CloseDate.addMonths(1); //DueDate APIName is ActivityDate
                oppTask.WhatId = opp.Id;
                oppTask.OwnerId=opp.OwnerId;
                
                newTasks.add(oppTask);
            }
           
            }
         If(!newTasks.isEmpty()){
                insert newTasks;
        }
    }

}