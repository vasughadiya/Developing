trigger Task1 on Opportunity (before update) {
    if(Trigger.isUpdate){
        Task1Handler.mymethod(Trigger.newMap, Trigger.oldMap);
    }
}