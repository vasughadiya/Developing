public with sharing class UpdateFieldOnOpportunitiesHandler {

    public static void updateFields(List<Opportunity> opportunities){

        for (Opportunity opportunity : opportunities) {
            opportunity.StageName = 'Prospecting';
            opportunity.CloseDate = Date.today().addDays(15);
            opportunity.Type = 'New Customer';
        }

    }

}