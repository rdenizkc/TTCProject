public class Story26_LeadBatch_2 implements Database.Batchable<sObject>, Schedulable {
    
            public void execute(SchedulableContext sc) {
                Database.executeBatch(new Story26_LeadBatch_2());
            }
        
            public Database.QueryLocator start(Database.BatchableContext BC) {
                String query = 'SELECT Id, LeadSource FROM Lead WHERE LeadSource = null';
                return Database.getQueryLocator(query);
            }
        
            public void execute(Database.BatchableContext BC, List<Lead> leads) {
                for (Lead lead : leads) { lead.LeadSource = 'Manual'; }
                Database.update(leads, false);
            }
        
            public void finish(Database.BatchableContext BC) { }
        }
        /*
        String schedule = '0 0 23 * * ?'; // Daily at 11 PM
        Story26_LeadBatch_2 batchJob = new Story26_LeadBatch_2();
        System.schedule('Story26_LeadBatch_2', schedule, batchJob);
         */