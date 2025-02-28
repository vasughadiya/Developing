trigger DebugTriggerContext on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
    if (Trigger.isBefore){
        DebugTriggerContextHandler.myMethod('before');
    }
    if (Trigger.isAfter){
        DebugTriggerContextHandler.myMethod('after');
    }
    if (Trigger.isInsert){
        DebugTriggerContextHandler.myMethod('insert');
    }
    if (Trigger.isUpdate){
        DebugTriggerContextHandler.myMethod('update');
    }
    if (Trigger.isDelete){
        DebugTriggerContextHandler.myMethod('delete');
    }
    if (Trigger.isUndelete){
        DebugTriggerContextHandler.myMethod('undelete');
    }
    
    
    
    System.debug('Trigger.new: ' + JSON.serializePretty(Trigger.new));
    System.debug('Trigger.newMap: ' + JSON.serializePretty(Trigger.newMap));
    System.debug('Trigger.old: ' + JSON.serializePretty(Trigger.old));
    System.debug('Trigger.oldMap: ' + JSON.serializePretty(Trigger.oldMap));
    System.debug('Trigger.size: ' + Trigger.size);
}