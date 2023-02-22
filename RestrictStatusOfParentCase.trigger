trigger RestrictStatusOfParentCase on Case (before update)
{
    RestrictStatusOfParentCaseHandler.restrictBeforeUpdate(Trigger.new, Trigger.oldMap);
}