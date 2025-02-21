// trigger CountTotalAmount on Contact (after insert, after update) {
//     if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
//         List<Contact> old = new List<Contact>();
//         if(Trigger.isUpdate){
//             old = Trigger.old;
//         }
//         CountTotalAmountHandler.updateTotalCount(Trigger.new, old);
//     }
// }

trigger CountTotalAmount on Contact (after insert, after update, after delete, after undelete) {
    if (Trigger.isAfter) {
        CountTotalAmountHandler.updateTotalCount(Trigger.oldMap, Trigger.newMap);
    }
}
