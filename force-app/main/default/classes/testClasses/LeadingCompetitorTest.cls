@IsTest
private class LeadingCompetitorTest {
    
    @IsTest
    static void createOppWithCompetitors(){

        //Create Opportunity
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opp';
        opp.CloseDate = Date.today();
        opp.StageName = 'Prospecting';
        
        //Populate price fields
        opp.Competitor_1_Price__c = 5000;
        opp.Competitor_2_Price__c = 10000;
        opp.Competitor_3_Price__c = 15000;

        //Populate competitor fields
        opp.Competitor_1__c = 'Amazon';
        opp.Competitor_2__c = 'Google';
        opp.Competitor_3__c = 'Salesforce';
        
        insert opp;
        System.debug('Opportunity ' + opp.Name + ' inserted with all competitior fields populated');
    }

}

