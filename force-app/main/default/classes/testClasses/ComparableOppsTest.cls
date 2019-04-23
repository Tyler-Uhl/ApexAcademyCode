@isTest
private class ComparableOppsTest {
    
    @isTest
    static void noComparableOpps() {

        Account acc = new Account();
        acc.Name = 'New Account';
        acc.Industry = 'Hospitality';
        insert acc;

        Opportunity opp = new Opportunity();
        opp.name = 'New Opportunity';
        opp.AccountId = acc.Id;
        opp.Amount = 100;
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today();
        insert opp;

        Comarable__c comparables = [SELECT Id
                                    FROM Comparable__c
                                    WHERE Base_Opportunity__c = :opp.Id];

        System.assertEquals(0,comparables.size());
    }

    @isTest
    static void multipleComparableOpps() {

        Account acc = new Account();
        acc.Name = 'New Account';
        acc.Industry = 'Hospitality';
        insert acc;

        List<Opportunity> comparableOpps = new List<Opportunity>();
        Opportunity opp1 = new Opportunity();
        opp1.name = 'New Opportunity 1';
        opp1.AccountId = acc.Id;
        opp1.Amount = 105;
        opp1.StageName = 'Closed Won';
        opp1.CloseDate = Date.today().addDays(-1);
        comparableOpps.add(opp1);

        Opportunity opp2 = new Opportunity();
        opp2.name = 'New Opportunity 2';
        opp2.AccountId = acc.Id;
        opp2.Amount = 105;
        opp2.StageName = 'Closed Won';
        opp2.CloseDate = Date.today().addDays(-100);
        comparableOpps.add(opp2);
        insert comparableOpps;

        Opportunity baseOpp = new Opportunity();
        baseOpp.name = 'Base Opportunity';
        baseOpp.AccountId = acc.Id;
        baseOpp.Amount = 100;
        baseOpp.StageName = 'Prospecting';
        baseOpp.CloseDate = Date.today();
        insert baseOpp;

        List<Comparable__c> comparables = [SELECT Id,
                                        Comparable_Opportunity__c
                                    FROM Comparable__c
                                    WHERE Base_Opportunity__c = :baseOpp.Id
                                    ORDER BY Comparable_Opportunity__r.CloseDate DESC];

        System.assertEquals(opp1.Id, comparables.get(0).Comparable_Opportunity__c);
        System.assertEquals(opp2.Id, comparables.get(1).Comparable_Opportunity__c);


    }
}
