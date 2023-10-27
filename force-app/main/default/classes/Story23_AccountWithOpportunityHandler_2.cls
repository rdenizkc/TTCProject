public class Story23_AccountWithOpportunityHandler_2 {
    public static void createOpportunity(List<Account> accounts) { // Buradaki accounts isimli List Trigger tarafında bulunan 
        															//Trigger.new Listi tarafından dolduruluyor.
        List<Opportunity> oppToInsert = new List<Opportunity>();
        Set<Id> accountIds = new Set<Id>();
        //Burada accounts isimli List'in (Trigger.new) içindeki recordların ID lerini depolamak için boş bir SET oluşturuldu
        //ve bu SET in içi aşağıdaki for each döngüsüyle dolduruldu.
        for(Account acc : accounts) { //Map yapısı kullanmadığımız için account'ları iterate ederk Id'lerini Set içerisine aldık.
            accountIds.add(acc.Id);
        }
        
        List<Opportunity> oppCheck = [SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :accountIds];
        //Burada accountIds içinde ki recordlar içerisinde related opportunity olup olmadığını kontrol etmek için 
        //bir sorgu oluşturuldu ve bu sorgunun sonucu oppCheck listinin içine aktarıldı. 
        //Bu kontrol Opportunity nin Account objecti üserinde bulunan Lookup bağlantısı (AccountId) vasıtasıyla yapıldı.
        
        for(Account acc : accounts) {
           //Burada oluşturulan for each döngüsü ve aşağıda kurulan If döngüsü ile, yukarıdaki 
           //sorgu sonucunda oppCheck Listinin boş dönmesi durumunda (yani Account a bağlı bir Opportunity olmaması durumunda)
           //Yeni bir Opportunity oluşturularak AccountId vasıtasıyla mevcut Account'a bağlandı.
            if(oppCheck.isEmpty()){
                Opportunity newOpportunity = new Opportunity();
                newOpportunity.Name = acc.Name + ' Opportunity';
                newOpportunity.StageName = 'Prospecting';
                newOpportunity.CloseDate = System.today().addDays(30);
                newOpportunity.AccountId = acc.Id;
                oppToInsert.add(newOpportunity);
            }
        }
        //Burada yukarıda bir Opportunity oluşturulup en başta oluşturulan oppToInsert Listesine 
        //atanıp atanmadığı kontrol edilerek, eğer atandıysa sisteme INSERT işlemi yapılmaktadır.
        if(!oppToInsert.isEmpty()) {
            insert oppToInsert;
        }
    }
}