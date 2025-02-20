trigger OpportunityNameChange on Opportunity (after update) {
    if (Trigger.isUpdate){
        OpportunityNameChangeHandler.createTaskOnNameChange(Trigger.new, Trigger.oldMap);
    }
}