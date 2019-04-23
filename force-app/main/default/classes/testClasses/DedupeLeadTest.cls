@IsTest
private class DedupeLeadTest {
    
    @IsTest
    static void createLeadNoDupes() {
        String leadOwner = UserInfo.getUserId();

        Lead myLead = new Lead();
        myLead.FirstName = 'Tyler';
        myLead.LastName = 'Test';
        myLead.Company = 'APU';
        myLead.Email = 'test@gmail.com';
        myLead.Description = 'Testing Trigger';
        myLead.OwnerID = leadOwner;
        insert myLead;

        Lead updatedLead = [SELECT OwnerID,
                                    Description
                                FROM Lead
                                WHERE Id = :myLead.Id];

        System.assertEquals(leadOwner, updatedLead.OwnerID);
        System.assertEquals(myLead.Description, updatedLead.Description);

    }

    @IsTest
    static void createLeadNoDupes() {
        String leadOwner = UserInfo.getUserId();
        String email = 'test@gmail.com';
        List<Contact> dupeContacts = new List<Contact>();

        Contact firstDup = new Contact();
        firstDup.FirstName = 'Tyler';
        firstDup.LastName = 'Test';
        firstDup.Email = email;
        dupeContacts.add(firstDup);

        Contact secondDup = new Contact();
        secondDup.FirstName = 'Tyler';
        secondDup.LastName = 'Test';
        secondDup.Email = email;
        dupeContacts.add(secondDup);
        insert dupeContacts;

        Lead myLead = new Lead();
        myLead.FirstName = 'Tyler';
        myLead.LastName = 'Test';
        myLead.Company = 'APU';
        myLead.Email = email;
        myLead.Description = 'Testing Trigger';
        myLead.OwnerID = leadOwner;
        insert myLead;


        Lead updatedLead = [SELECT OwnerID,
                                    Description
                                FROM Lead
                                WHERE Id = :myLead.Id];
        Group dataQualityQueue = [SELECT Id
                                    FROM Group
                                    WHERE DeveloperName = 'Data_Quality'
                                    LIMIT 1];
        System.assertEquals(dataQualityQueue.Id, updatedLead.OwnerID);
        System.assert(updatedLead.Description.contains(firstDup.Id));
        System.assert(updatedLead.Description.contains(secondDup.Id));

    }
}


