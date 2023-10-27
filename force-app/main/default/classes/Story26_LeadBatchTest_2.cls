@isTest
public class Story26_LeadBatchTest_2 {
        @IsTest
        static void executeLeadBatchPositiveTest_2() {
            // Create a new Lead with Lead Source as null
            Lead testLead1 = new Lead();
            testLead1.LastName = 'Test Lead';
            testLead1.Company = 'Test Company'; // Set a value for the Company field
            testLead1.Status='Open - Not Contacted';
            insert testLead1;
            
            Story26_LeadBatch_2 mybatch = new Story26_LeadBatch_2();
            Test.startTest();
                Database.executeBatch(mybatch);
            Test.stopTest();

            Lead testLead2 = [SELECT Id, LeadSource FROM Lead WHERE Id=:testLead1.Id];

            Assert.areEqual ('Manual', testLead2.LeadSource, 'Updated LeadSource is not valid');
        }

        @isTest
        static void executeLeadBatchNegativeTest_2(){
            Lead testLead1 = new Lead();
            testLead1.LastName = 'Test Lead';
            testLead1.Company = 'Test Company'; // Set a value for the Company field
            testLead1.Status='Open - Not Contacted';
            testLead1.LeadSource='Web';
            insert testLead1;

            Story26_LeadBatch_2 mybatch = new Story26_LeadBatch_2();
            Test.startTest();
                Database.executeBatch(mybatch);
            Test.stopTest();

            Lead testLead2 = [SELECT Id, LeadSource FROM Lead WHERE Id=:testLead1.Id];

            System.assertNotEquals ('Manual', testLead2.LeadSource, 'Updated LeadSource is not valid');
       }

        @isTest
        static void scheduleLeadBatchTest_2(){
            Test.startTest();
                Story26_LeadBatch_2 myScheduledBatch = new Story26_LeadBatch_2();
                String cronExp='0 0 23 * * ?';
                String JobId= System.schedule('Lead batch Test', cronExp, myScheduledBatch);

                CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime 
                                FROM CronTrigger 
                                WHERE id = :JobId];
                Assert.areEqual(cronExp, ct.CronExpression);
                Assert.areEqual(0, ct.TimesTriggered);
            Test.stopTest();
        }
}