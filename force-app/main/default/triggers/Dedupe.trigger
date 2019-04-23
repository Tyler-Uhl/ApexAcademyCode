trigger Dedupe on Account (after insert) {
    for (Account acc : trigger.new){
        Case c = new Case();
        //c.OwnerId = 
        c.Subject = 'Dedupe this account';
        c.AccountId = acc.Id;
        insert c;
    }
}