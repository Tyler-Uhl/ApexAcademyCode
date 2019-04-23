@isTest
private class DedupeTest {

    @IsTest static void createAccount() {

        Account acc = new Account();
        acc.Name = 'Apex Tutorial';
        insert acc;
    }
}

