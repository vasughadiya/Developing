public with sharing class AccountRelatedOpportunitiesController {

    public String selectedAccountId {get; set;}
    public Integer oppPageSize = 5;
    public Integer oppPageNumber = 1;

    public List<SelectOption> getAccount(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '--select Account--'));
        for (Account acc : [SELECT Id, Name from Account]){
            options.add(new SelectOption(acc.Id, acc.Name));
        }
        return options;
    }
    
    public List<Opportunity> getOpportunities() {
        if (selectedAccountId == null || selectedAccountId == '') return new List<Opportunity>();
        return [SELECT Id, Name, CloseDate FROM Opportunity WHERE AccountId = :selectedAccountId LIMIT :oppPageSize OFFSET :((oppPageNumber-1) * oppPageSize)];
    }

    public Boolean getOppDisablePrevious() {
        return oppPageNumber == 1;
    }

    public Boolean getOppDisableNext() {
        Integer totalOpps = [SELECT COUNT() FROM Opportunity WHERE AccountId = :selectedAccountId];
        return (oppPageNumber * oppPageSize) >= totalOpps;
    }

    public void loadOpportunities() {
        oppPageNumber = 1;
    }

    public void oppNext() {
        oppPageNumber++;
    }

    public void oppPrevious() {
        oppPageNumber--;
    }

    public AccountRelatedOpportunitiesController() {

    }
}