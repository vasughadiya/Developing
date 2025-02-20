trigger DebugTriggerContext on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
    if (Trigger.isBefore){
        DebugTriggerContextHandler.myMethod('before');
    } else if (Trigger.isAfter){
        DebugTriggerContextHandler.myMethod('after');
    } else if (Trigger.isInsert){
        DebugTriggerContextHandler.myMethod('insert');
    } else if (Trigger.isUpdate){
        DebugTriggerContextHandler.myMethod('update');
    } else if (Trigger.isDelete){
        DebugTriggerContextHandler.myMethod('delete');
    } else if (Trigger.isUndelete){
        DebugTriggerContextHandler.myMethod('undelete');
    }

    System.debug('Trigger.new: ' + JSON.serializePretty(Trigger.new));
    System.debug('Trigger.newMap: ' + JSON.serializePretty(Trigger.newMap));
    System.debug('Trigger.old: ' + JSON.serializePretty(Trigger.old));
    System.debug('Trigger.oldMap: ' + JSON.serializePretty(Trigger.oldMap));
    System.debug('Trigger.size: ' + Trigger.size);
}   
