@isTest
private class OpportunityNameChangeTest {

    @testSetup
    static void setupTestData() {
        Opportunity opp = new Opportunity(
            Name = 'Initial Opportunity Name',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(10)
        );
        insert opp;
    }

    @isTest
    static void oppoNameChangeTest() {
        Opportunity opp = [SELECT Id, Name FROM Opportunity LIMIT 1];
        opp.Name = 'Updated Opportunity Name';
        Test.startTest();
        update opp; 
        Test.stopTest();
    }
}

// Handler : 100%
// Trigger : 100%