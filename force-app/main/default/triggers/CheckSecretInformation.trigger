trigger CheckSecretInformation on Case (after insert, before update) {
 
    String childCaseSubject = 'Warning: Parent case may contain secret info';
    // Create a collegtion containing each of our secret keywords
    Set<String> secretKeywords = new Set<String>(); 
    secretKeywords.add('Credit Card');
    secretKeywords.add('Social Security');
    secretKeywords.add('SSN');
    secretKeywords.add('Passport');
    secretKeywords.add('Bodyweight');

    // Check to see if our case contains any of the secret keywords
    List<Case> casesWithSecretInfo = new List<Case>();
    for (Case myCase : Trigger.new) {
        if (myCase.Subject != childCaseSubject){
            for (String keyword : secretKeywords){
                if (myCase.Description != null && myCase.Description.containsIgnoreCase(keyword)){
                    casesWithSecretInfo.add(myCase);
                    break;
                }
            }
        }
    }
        // If our case contains a secret keyword, create a child case
    List<Case> casesToCreate = new List<Case>();
    for (Case casesWithSecretInfo : casesWithSecretInfo){
        Case childCase = new Case();
        childCase.Subject = 'Warning: Parent case may contain secret info';
        childCase.ParentID = casesWithSecretInfo.Id;
        childCase.IsEscalated = true;
        childCase.Priority = 'High';
        childCase.Description = 'At least one of the following keywords were found ' + secretKeywords;
        casesToCreate.add(childCase);
    }
    insert casesToCreate;
}