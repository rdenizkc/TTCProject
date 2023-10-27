trigger Story22_ContactTrigger_2 on Contact (after insert, after update, after delete, after undelete){
	if(Trigger.isAfter && Trigger.isUpdate){
   Story22_ContactTriggerHandler_2.updateActiveContactsField(Trigger.new);
}
    if(Trigger.isAfter && Trigger.isInsert){
   Story22_ContactTriggerHandler_2.updateActiveContactsField(Trigger.new);
}
     if(Trigger.isAfter && Trigger.isDelete){
   Story22_ContactTriggerHandler_2.updateActiveContactsField(Trigger.old);
}
     if(Trigger.isAfter && Trigger.isUndelete){
   Story22_ContactTriggerHandler_2.updateActiveContactsField(Trigger.new);
}
}