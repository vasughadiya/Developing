trigger UpdateRatingOnLead on Lead (before insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
        UpdateRatingOnLeadHandler.updatingLead(Trigger.new);
    }
}