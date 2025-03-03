trigger DeleteSameNameAccounts on Account (before insert) {
    if (Trigger.isInsert && Trigger.isBefore){
        DeleteSameNameAccountsHandler.deleteAccount(Trigger.new);
    }
}