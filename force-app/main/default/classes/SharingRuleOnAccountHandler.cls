public with sharing class SharingRuleOnAccountHandler {
    
        public static void shareAccount(List<Account> updatedAccounts, Map<Id, Account> oldAccountMap) {
            List<AccountShare> accountShares = new List<AccountShare>();
    
            User wilsonUser = [SELECT Id FROM User WHERE Name = 'Manager User' LIMIT 1];
    
            if (wilsonUser == null) {
                System.debug('user not found. Sharing aborted.');
                return;
            }
    
            for (Account acc : updatedAccounts) {
                Account oldAcc = oldAccountMap.get(acc.Id);
    
                if (acc.Rating == 'Hot' && oldAcc.Rating != 'Hot') {
                    AccountShare share = new AccountShare();
                    share.AccountId = acc.Id;
                    share.UserOrGroupId = wilsonUser.Id; 
                    share.AccountAccessLevel = 'Read';
                    share.OpportunityAccessLevel = 'None'; 
                    share.CaseAccessLevel = 'None';
                    accountShares.add(share);
                }
            }
    
            if (!accountShares.isEmpty()) {
                try {
                    insert accountShares;
                    System.debug('Account shared successfully');
                } catch (DmlException e) {
                    System.debug('Error : ' + e.getMessage());
                }
            }
        }
        
    public SharingRuleOnAccountHandler() {

    }
}