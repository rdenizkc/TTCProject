@isTest
public class Story23_AccountWithOpportunity_Test_2 {
    @testSetup
    static void dataFactory(){
        Account acc = new Account (Name='testAccount');
        insert acc;
    }
    @isTest
    static void insertAccTest() {
        // Create test Account
        Account acc = [SELECT Id, Name FROM Account WHERE Name = 'testAccount'];
        // Bu bölümde Account kaydı oluşturulduğunda Opportunity kaydı oluşturulup oluşturulmadığı test ediliyor.
        // Verify that an Opportunity has been created
        List<Opportunity> opps = [SELECT Id, Name, StageName, CloseDate, AccountId FROM Opportunity WHERE AccountId =: acc.Id];
        Assert.areEqual(1, opps.size());
        Assert.areEqual(acc.Id, opps[0].AccountId);
        Assert.areEqual(acc.Name + ' Opportunity', opps[0].Name);
        Assert.areEqual('Prospecting', opps[0].StageName);
        Assert.areEqual(Date.today().adddays(30), opps[0].CloseDate);
    }   
    @isTest
        static void updateAccTest() {
        // Update the Account
        Account acc = [SELECT Id, Name FROM Account WHERE Name = 'testAccount'];      
        List<Opportunity> opp = [SELECT Id FROM Opportunity WHERE AccountId =:acc.Id];
        System.assert(opp.size()>0, 'Account için oluşturulmuş bir Opportunity bulunamadı!');
        delete opp;
        List<Opportunity> opp2 = [SELECT Id FROM Opportunity WHERE AccountId =:acc.Id];
        System.assert(opp2.isEmpty());
        acc.Name = 'testAccount_updated';
        Test.startTest();
            update acc;
        Test.StopTest();
        
        // Bu bölümde Account kaydı güncellendiğinde eğer Opportunity kaydı yoksa yenisinin 
        // oluşturulup oluşturulmadığı test ediliyor.
        
        // Verify that a new Opportunity has been created
        List<Opportunity> opps = [SELECT Id, Name, StageName, CloseDate, AccountId FROM Opportunity WHERE AccountId =: acc.Id];
        Assert.areEqual(1, opps.size());
        Assert.areEqual(acc.Id, opps[0].AccountId);
        Assert.areEqual(acc.Name + ' Opportunity', opps[0].Name);
        Assert.areEqual('Prospecting', opps[0].StageName);
        Assert.areEqual(Date.today().adddays(30), opps[0].CloseDate);
    }
}