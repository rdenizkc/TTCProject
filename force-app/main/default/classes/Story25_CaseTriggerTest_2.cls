@isTest
public class Story25_CaseTriggerTest_2 {
	@isTest
    static void testCaseHandlerTest() {
        
        // Create a new account
        Account acc = new Account(Name = 'testAccount');
        insert acc;
        
        // Create two new cases for the account
        Case oldCase1 = new Case( Subject='testSubject1',Status='New',Origin='Web',Priority= 'Low', AccountId=acc.Id);
        Case oldCase2 = new Case( Subject='testSubject2',Status='Working',Origin='Phone',Priority= 'High', AccountId=acc.Id);
        
        insert oldCase1;
        insert oldCase2;
        
        Case childCase = new Case( Subject='testSubject3',Status='New',Origin='Web',Priority= 'High', AccountId=acc.Id);
        Test.startTest();
            insert childCase;
        Test.stopTest();
        
        Case updatedChildCase = [SELECT Id, ParentId FROM Case WHERE Subject = 'testSubject3' LIMIT 1];
       Assert.areEqual(oldCase1.Id, updatedChildCase.ParentId, 'Parent Case ataması yapılmamış!');
    }
}