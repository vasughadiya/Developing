trigger SheepProblem on Contact (after update) {
    if(Trigger.isUpdate){
        SheepProblemHandler.updateContacts(Trigger.new, Trigger.oldMap);
    }
}