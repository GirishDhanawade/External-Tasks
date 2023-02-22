@isTest
public class RestrictStatusOfParentCaseHandlerTest
{ 
    @isTest
    static void testParentCaseNotClosed() 
    {
        Case parentCase = new Case(Status='New');
        insert parentCase;
        
        Case childCase1 = new Case(ParentId=parentCase.Id, Status='New');
        insert childCase1;
        
        Case childCase2 = new Case(ParentId=parentCase.Id, Status='New');
        insert childCase2;
        
        Case childCase3 = new Case(ParentId=parentCase.Id, Status='New');
        insert childCase3;
        
        parentCase.Status = 'Closed';
        Test.startTest();
        update parentCase;
        Test.stopTest();
        
        // Parent case should not be closed ....We are checking that
        System.assertEquals('New', [SELECT Status FROM Case WHERE Id=:parentCase.Id].Status);
    }
    @isTest
    static void testParentCaseClosed() 
    {
        Case parentCase = new Case(Status='New');
        insert parentCase;
        
        Case childCase1 = new Case(ParentId=parentCase.Id, Status='Closed');
        insert childCase1;
        
        Case childCase2 = new Case(ParentId=parentCase.Id, Status='Closed');
        insert childCase2;
        
        Case childCase3 = new Case(ParentId=parentCase.Id, Status='Closed');
        insert childCase3;
        
        parentCase.Status = 'Closed';
        Test.startTest();
        update parentCase;
        Test.stopTest();
        
       // Parent case should be closed ....We are checking that
        System.assertEquals('Closed', [SELECT Status FROM Case WHERE Id=:parentCase.Id].Status);
    }
    
}