trigger DedupeLead on Lead (before insert) {
    List<Group> dataQualityGroup = [SELECT Id
                                FROM Group
                                WHERE DeveloperName = 'Data_Quality'
                                LIMIT 1];
    for (Lead myLead : Trigger.new){
        if (myLead.Email != null){
            List<Contact> matchingContacts = [SELECT Id,
                                                    FirstName,
                                                    LastName,
                                                    Account.Name
                                                FROM Contact
                                            WHERE Email = :myLead.Email];
            System.debug(matchingContacts.size() + ' contact(s) found.');

            if (!matchingContacts.isEmpty()){

                if(!dataQualityGroup.isEmpty()){
                    myLead.OwnerID = dataQualityGroup.Id;
                }

                String dupContactMessage = 'Duplicate contact(s) found:\n';
                for (Contact matchingContact : matchingContacts){
                    dupContactMessage += matchingContact.FirstName + ' '
                                    + matchingContact.LastName + ' '
                                    + matchingContact.Account.Name + ' '
                                    + matchingContact.Id + ')\n';
                }
                if (myLead.Description != null{
                    myLead.Description = dupContactMessage + '\n' + myLead.Description;
                }
                myLead.Description = dupContactMessage;
            }
        }
    }
}