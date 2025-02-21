trigger TheGreatProblem on Contact (after insert, before update) {
    if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        TheGreatProblemHandler.greatProblem(Trigger.new);
    }
}