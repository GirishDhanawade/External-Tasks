//If all three child cases of parent case is closed
//then and only then allow the parent case to change into closed stage
public class RestrictStatusOfParentCaseHandler 
{
    public static void restrictBeforeUpdate(List<Case> newCases, Map<Id, Case> oldMap) {
        Set<Id> parentCaseIds = new Set<Id>();
        for (Case c : newCases)
        {
            if (c.Status == 'Closed' && oldMap.get(c.Id).Status != 'Closed') 
            {
                parentCaseIds.add(c.ParentId);
            }
        }
        List<Case> childCases = [SELECT Id, Status, ParentId FROM Case WHERE ParentId IN :parentCaseIds];
        Map<Id, Boolean> parentToChildStatus = new Map<Id, Boolean>();
        for (Case childCase : childCases) 
        {
            if (childCase.Status != 'Closed')
            {
                parentToChildStatus.put(childCase.ParentId, false);
            } else if (!parentToChildStatus.containsKey(childCase.ParentId))
            {
                parentToChildStatus.put(childCase.ParentId, true);
            }
        }
        for (Id parentId : parentCaseIds) {
            if (!parentToChildStatus.get(parentId))
            {
                Case parentCase = oldMap.get(parentId);
                parentCase.addError('All child cases must be closed then and only then we can change the parent status to close');
            }
        }
    }
}