@isTest
private class TheGreatProblemTest {
    
    @TestSetup
    static void setup(){
        Account a1 = new Account(Name = 'A1', Max_Limit__c = 30);
        insert a1;
        List<Contact> contacts = new List<Contact>{
            new Contact(LastName = 'C1', AccountId = a1.Id),
            new Contact(LastName = 'C2', AccountId = a1.Id)
        };
        insert contacts;
    }
    
    @isTest
    static void myUnitTest() {
        Test.startTest();
        Account a1 = new Account(Name = 'A1', Max_Limit__c = 30);
        insert a1;
        Contact c3 = new Contact(
            LastName = 'C3',
        AccountId = a1.Id,
        Limit__c = 45
            );
        insert c3;
        Test.stopTest();
        // Handler : 80%
        // Trigger : 100%
    }
}