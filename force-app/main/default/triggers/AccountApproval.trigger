trigger AccountApproval on Account (after insert) {
    if (Trigger.isInsert){
        AccountApprovalHandler.submitForApproval(Trigger.new);
    }
}