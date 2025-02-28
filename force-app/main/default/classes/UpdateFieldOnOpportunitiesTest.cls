/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class UpdateFieldOnOpportunitiesTest {

    @isTest
    static void UpdateFieldOnOpportunity() {
        Test.startTest();
        
        Opportunity opp = new Opportunity(Name = 'Name Test', CloseDate = Date.today().addDays(5), StageName = 'Qualification');
        insert opp;
        Opportunity opp1 = [SELECT Id, Name, StageName, CloseDate, Type FROM Opportunity WHERE Name = 'Name Test' LIMIT 1];
        opp1.Name = 'Name Test 2';
        update opp1;

        Test.stopTest();

        System.assertEquals('Prospecting', opp1.StageName, 'Opportunity Stage Name is not correct');
        System.assertEquals(Date.today().addDays(15), opp1.CloseDate, 'Opportunity Close Date is not correct');
        System.assertEquals('New Customer', opp1.Type, 'Opportunity Type is not correct');
    }
}

// handler : 100%
// trigger : 100%