public with sharing class SAManager_2 {
  
    @AuraEnabled(cacheable=true scope='global')
    public static List<SA_Detail_2__c> getAllSA(){

        return [SELECT Id, Name, Experience_2__c,Name_2__c,Customer_Handled_2__c,Date_of_Joining_2__c,Specilization_2__c,Location_2__Latitude__s, Location_2__Longitude__s FROM SA_Detail_2__c ORDER BY Name LIMIT 20];
        
    }
	
	@AuraEnabled(cacheable=true scope='global')
    public static List<SA_Detail_2__c> searchSas(String searchTerm) {
        
        searchTerm = searchTerm.trim();
        if (searchTerm == '') {
        return getAllSA();
        }
        
        searchTerm = '%' + searchTerm + '%';  // wildcard
        
        return [
            SELECT
                Id,
                Name,
                Experience_2__c,
                Name_2__c,
                Customer_Handled_2__c,
                Date_of_Joining_2__c,
            	Location_2__Latitude__s, 
                Location_2__Longitude__s,
                Specilization_2__c
            FROM SA_Detail_2__c
            WHERE Name LIKE :searchTerm
            WITH SECURITY_ENFORCED
            ORDER BY Name
            LIMIT 20
        ];
    }
}