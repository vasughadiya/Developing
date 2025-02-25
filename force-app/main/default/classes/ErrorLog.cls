public with sharing class ErrorLog {
    
    
    public static void logError(Exception e, String className, String methodName, String moreDetails) {
        try {
            Error_Log__c errorLog = new Error_Log__c();
            errorLog.Name = className;
            errorLog.Method_Name__c = methodName;
            errorLog.Exception_Message__c = e.getMessage();
            errorLog.Line_Number__c = e.getLineNumber();
            errorLog.Exception_Type__c = e.getTypeName();
            errorLog.More_Details__c = moreDetails;
            
            insert errorLog;
        } catch (Exception err) {
            System.debug('Error logging exception: ' + err.getMessage());
        }
    }
    
    
    public ErrorLog() {
        
    }
}

