trigger UpdateFieldOnOpportunities on Opportunity (before insert, before update) {
    if (Trigger.isBefore && Trigger.isInsert){
        UpdateFieldOnOpportunitiesHandler.updateFields(Trigger.new);
    }
}