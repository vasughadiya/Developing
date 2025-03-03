public class AccountPrefixHandler {
    public static void addPrefixToAccountName(List<Account> newAccounts) {
        Set<Id> accountIds = new Set<Id>();
        for (Account acc : newAccounts) {
            acc.Name = 'Mr. '+acc.Name;
        }
    }
}