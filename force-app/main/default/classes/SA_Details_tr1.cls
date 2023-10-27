public with sharing class SA_Details_tr1 {
    @AuraEnabled(cacheable = true)
    public static List<SA_Detail_tr1__c> getSADetails(String name){
        return [SELECT Name, Customer_Handled_tr1__c, Experience_tr1__c, Date_of_Joining_tr1__c, Location_tr1__c, Location_tr1__Longitude__s, Location_tr1__Latitude__s
                FROM SA_Detail_tr1__c WHERE Name LIKE :'%'+name+'%' ORDER BY CreatedDate DESC LIMIT 6];
    }
}