trigger Story23_AccountWithOpportunityTrigger_2 on Account (after insert, after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        Story23_AccountWithOpportunityHandler_2.createOpportunity(Trigger.new);
        //Burada handler class ismi ve method ismi çağrılarak trigger çalıştırıldı. 
        //Aynı zamanda parantez içindeki (Trigger.new) listi de handler tarafında (accounts) List i olarak karşılandı.
    }
}