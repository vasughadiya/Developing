trigger SharingRuleOnAccount on Account (after update) {
    if (Trigger.isUpdate){
        SharingRuleOnAccountHandler.shareAccount(Trigger.new, Trigger.oldMap);
    }
}