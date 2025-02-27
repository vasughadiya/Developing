global with sharing class tenOpportunitiesEveryDay implements Schedulable {
    
    
    public static void createTenOppo (){
        List<Opportunity> tenOpportunities = new List<Opportunity>();
        for (Integer i = 0; i < 10; i++) {
            Opportunity opp = new Opportunity();
            opp.Name = 'Oppo from scheduled class ' + i + System.now().date();
            opp.CloseDate = System.now().date().addDays(3);
            opp.StageName = 'Prospecting';
            tenOpportunities.add(opp);
        }
        insert tenOpportunities;
        System.debug('Scheduled Opportunities Created');
    }
    
    global void execute(SchedulableContext s) {
        System.debug('Scheduled Opportunities Created');
        createTenOppo();
    }
    
    
    public tenOpportunitiesEveryDay() {
        
    }
}

// String cronExp = '0 30 11 * * ?'; // Every day at 11:30 AM
// System.schedule('Daily Opportinities Creations 1', cronExp, new tenOpportunitiesEveryDay());