public with sharing class UpdateRatingOnLeadHandler {
    
    public static void updatingLead(List<Lead> Leads){
        for(Lead l: Leads){
            l.Rating = 'Warm';
        }
    }
}