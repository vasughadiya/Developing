trigger CountTotalAmount on Contact (after insert, after update, after delete, after undelete) {
    if (Trigger.isAfter) {
        CountTotalAmountHandler.updateTotalCount(Trigger.oldMap, Trigger.newMap);
    }
}