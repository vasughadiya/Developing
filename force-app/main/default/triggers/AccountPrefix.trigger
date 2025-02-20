trigger AccountPrefix on Account (before insert) {
    if(Trigger.isInsert){
        AccountPrefixHandler.addPrefixToAccountName(Trigger.new);
    }
}