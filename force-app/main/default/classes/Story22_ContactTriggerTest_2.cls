@isTest
public class Story22_ContactTriggerTest_2 {

    @testSetup
    static void dataFactory(){
        Account acc = new Account(name='testAccount');
        insert acc;
        List<Contact> conList = new List<Contact>{
            new Contact (lastName='testContact1', AccountId=acc.Id, Active_2__c=true),
            new Contact (lastName='testContact2', AccountId=acc.Id, Active_2__c=true),
            new Contact (lastName='testContact3', AccountId=acc.Id, Active_2__c=false)
                
        };
        insert conList;
        Account accUpdated = [SELECT Id, Active_Contacts_2__c FROM Account WHERE Id = :acc.Id];
        Assert.areEqual(2, accUpdated.Active_Contacts_2__c);

             
    }
	@isTest
    static void contactDMLTest(){
        Contact con = [SELECT Id, LastName FROM Contact WHERE LastName = 'testContact1' LIMIT 1];
        con.lastName += 'Updated';
        con.Active_2__c = false;
        
        Test.startTest();
        update con;
        Test.stopTest();
        Account accUpdated = [SELECT Id, Active_Contacts_2__c FROM Account WHERE Name = 'testAccount' LIMIT 1];
        Assert.areEqual(1, accUpdated.Active_Contacts_2__c);
        System.assertNotEquals(2, accUpdated.Active_Contacts_2__c);
 
    }
    
    @isTest 
    static void testPassiveCon (){
        Account acc = new Account (Name='testAccount2');
        insert acc;
        Contact con4 = new Contact (LastName='testContact4', AccountId=acc.Id, Active_2__c=false); 
		insert con4;
        
        Account accUpdated = [SELECT Id, Active_Contacts_2__c FROM Account WHERE Name = 'testAccount2' LIMIT 1];
        Assert.areEqual(0, accUpdated.Active_Contacts_2__c);
        System.assertNotEquals(1, accUpdated.Active_Contacts_2__c);
        
    } 
    
    @isTest 
    static void testDelete (){
        Contact con = [SELECT Id, LastName FROM Contact WHERE LastName = 'testContact1' LIMIT 1];
        Test.startTest();
        delete con;
        
        Account accUpdated = [SELECT Id, Active_Contacts_2__c FROM Account WHERE Name = 'testAccount' LIMIT 1];
       
        Assert.areEqual(1, accUpdated.Active_Contacts_2__c);
        System.assertNotEquals(2, accUpdated.Active_Contacts_2__c);
       	
        undelete con;
        Test.stopTest();
        Account accUpdated2 = [SELECT Id, Active_Contacts_2__c FROM Account WHERE Name = 'testAccount' LIMIT 1];
        Assert.areEqual(2, accUpdated2.Active_Contacts_2__c);
        System.assertNotEquals(1, accUpdated2.Active_Contacts_2__c);
    }
    
}