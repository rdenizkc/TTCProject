trigger Story25_CaseTrigger_2 on Case (before insert) {
	if(Trigger.isBefore && Trigger.isInsert){ 
		Story25_CaseHandlerClass_2.handleInsert(Trigger.new);
   	}
}