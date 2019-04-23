trigger ComparableOpps on Opportunity (after insert) {

    for (Opportunity opp : Trigger.new){
        Opportunity oppWithAccountInfo = [SELECT Id,
                                                  Account.Industry
                                                  FROM Opportunity
                                                  WHERE Id = :opp.Id
                                                  LIMIT 1];

        Decimal minAmount = opp.Amount + 0.9;
        Decimal MaxAmount = opp.Amount + 1.1;

        List <Opportunity> comparableOpps = [SELECT Id
                                                FROM Opportunity
                                                WHERE Amount >= :minAmount
                                                AND AMmount <= :masAmount
                                                AND Account.Idustry = :oppWithAccountInfo.Account.Industry
                                                AND StageName = 'Closed Won'
                                                AND ClosedDate >= LAST_N_DAYS:365
                                                AND Id != :opp.Id];

        List<Comparable__c> junctionObjToInster = new List<Comparable__c>();
        for (Opportunity comp : comparableOpps){
            Comparable__c junctionObj = new Comparable__c();
            junctionObj.Base_Opportunity__c = opp.Id;
            junctionObj.Comparable_Opportuniy__c = comp.Id;
            junctionObjToInster.add(junctionObj);
        }
        insert junctionObjToInster;
    }
}