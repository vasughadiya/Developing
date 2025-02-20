trigger AccountDeleteOnContactDelete on Contact (after delete) {
    if (Trigger.isDelete){
        AccountDeleteOnContactDeleteHandler.deleteRelatedAccounts(Trigger.old);
    }
}