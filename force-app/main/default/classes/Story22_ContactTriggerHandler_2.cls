public class Story22_ContactTriggerHandler_2 {
	public static void updateActiveContactsField(List<Contact> conList){
    Set <Id> accountIds = new Set <Id>();
    List <Account> activeContactsToUpdate = new List <Account>();

    for(Contact con:conList){ // Account bilgisi boş olmayan contact'ların Id'sini set içine yerleştirdik.
		if (String.isNotBlank(con.AccountId)){
        accountIds.add(con.accountID);
		}
    }

	for(Account acc:[SELECT Id,Name,Active_Contacts_2__c,(Select Id from Contacts where Active_2__c = :True) from Account where Id IN: accountIds]){
    	Account accObj = new Account ();
            // isEmpty() method returns true if the list has zero elements
            if(!acc.Contacts.isEmpty()){ // acc.Contacts = List<Contact>
        		// size() method returns the number of elements in the list
                acc.Active_Contacts_2__c = acc.Contacts.size();
                activeContactsToUpdate.add(acc);
            }else{
        		// if there is no active contact set it to Zero
                acc.Active_Contacts_2__c = 0;
                activeContactsToUpdate.add(acc);
            }
        }
		update activeContactsToUpdate; 
    }
}