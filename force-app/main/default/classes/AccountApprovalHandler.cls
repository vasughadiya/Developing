public with sharing class AccountApprovalHandler {
     
    public static void submitForApproval(List<Account> newAccounts) {
        List<Approval.ProcessSubmitRequest> approvalRequests = new List<Approval.ProcessSubmitRequest>();
        
        for (Account acc : newAccounts) {
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setObjectId(acc.Id);
            req.setSubmitterId(UserInfo.getUserId());
            req.setProcessDefinitionNameOrId('Account_Approval_Process');
            req.setComments('Automatically submitted for approval upon creation.');
            
            approvalRequests.add(req);
        }
        
        if (!approvalRequests.isEmpty()) {
            try {
                Approval.ProcessResult[] results = Approval.process(approvalRequests);
                System.debug('Approval Process Results: ' + results);
            } catch (Exception e) {
                System.debug('Error submitting for approval: ' + e.getMessage());
            }
        }
    }
}