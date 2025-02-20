trigger AccountNameChangeAlert on Account (after update) {
    if (Trigger.isUpdate){
        AccountNameChangeAlertHandler.sendEmailOnNameChange(Trigger.new, Trigger.oldMap);
    }
}