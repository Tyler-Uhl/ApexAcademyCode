@isTest
private class HelloWorldTest {

    @IsTest static void updateLead() {

        Lead myLead = new Lead();
        myLead.FirstName = 'Tyler';
        myLead.LastName = 'Uhl';
        myLead.Company = 'APU';
        insert myLead;

        myLead.Company = 'Azusa Pacific Univeristy';
        update myLead;

        
    }
}

