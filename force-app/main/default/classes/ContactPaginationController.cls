public with sharing class ContactPaginationController {
    public Integer pageSize = 10;
    public Integer pageNumber = 1;
    public String selectedAccountId {get; set;}
    public Integer oppPageSize = 5;
    public Integer oppPageNumber = 1;
    
    public List<Contact> getContacts() {
        return [SELECT Id, Name, Account.Name,Email FROM Contact LIMIT :pageSize OFFSET :((pageNumber-1) * pageSize)];
    }

    public Boolean getDisablePrevious() {
        return pageNumber == 1;
    }

    public Boolean getDisableNext() {
        Integer totalContacts = [SELECT COUNT() FROM Contact];
        return (pageNumber * pageSize) >= totalContacts;
    }

    public void next() {
        pageNumber++;
    }

    public void previous() {
        pageNumber--;
    }

    public List<SelectOption> getAccountOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '-- Select an Account --'));
        for (Account acc : [SELECT Id, Name FROM Account]) {
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
}
