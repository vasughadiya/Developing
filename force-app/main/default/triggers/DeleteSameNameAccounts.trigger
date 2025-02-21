trigger DeleteSameNameAccounts on Account (before insert) {
    if (Trigger.isInsert && Trigger.isBefore){
        DeleteSameNameAccountsHandler.deleteAccount(Trigger.new);
    // } else if (Trigger.isInsert && Trigger.isAfter) {
    //     DeleteSameNameAccountsHandler.CountTotalAmount(Trigger.new);
    }
}