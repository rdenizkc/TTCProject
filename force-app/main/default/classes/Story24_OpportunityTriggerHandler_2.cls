public class Story24_OpportunityTriggerHandler_2 {
    
    public static void afterUpdateHandler_2(List<Opportunity> oppList_2, Map<Id,Opportunity> oldOppList_2){
        //Burada oppList_2 Trigger tarafırda bulunan Trigger.new listi ile, oldOppList_2 ise trigger tarafında bulunan Trigger.oldMap ile dolduruluyor.
        
        List<Task> taskList_2 = new List<Task>();//for each döngüsü sonucunda oluşacak Task object'lerini depolamak için Task List oluşturuldu.
        
        for(Opportunity opp_2 : oppList_2 ){//Trigger.new'den gelen oppList_2 verileri opp_2'nin içine for each ile yüklendi.
            
            Opportunity oldOpp_2 = oldOppList_2.get(opp_2.Id); //Trigger.oldMap'ten gelen Opportunity'nin eski halini Id ile aldık ve oldOpp_2'nin içine yükledik.
            
            if(oldOpp_2.StageName != 'Closed Won' && opp_2.StageName == 'Closed Won'){//Opportunity'nin stage fieldinin eski ve yeni halini karşılaştırdık.
                //Stage Name'in eski hali 'Closed Won' değil ve yeni hali 'Closed Won' ise true olacak ve aşağıdaki Task oluşturulacak.
                
                Task newTask_2 = new Task(Subject = 'Follow up Task', 
                    ActivityDate = opp_2.CloseDate.addMonths(1), 
                    WhatId = opp_2.Id, 
                    OwnerId = opp_2.OwnerId);
                taskList_2.add(newTask_2);
            }
            
        }
        //Burada yukarıdaki Task oluşturulup taskList_2 listesine atanıp atanmadığı kontrol edilerek, eğer atandıysa INSERT işlemi yapılmaktadır.
        if(!taskList_2.isEmpty()){
            insert taskList_2;
        }       
    }
}