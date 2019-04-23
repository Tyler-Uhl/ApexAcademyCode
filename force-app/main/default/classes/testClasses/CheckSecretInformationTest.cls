@IsTest
private class CheckSecretInformationTest {

    @IsTest
    static void createCaseWithSecretInfo() {
        Case myCase = new Case();
        myCase.Subject = 'Test';
        myCase.Description = 'SSN';
        insert myCase;

    }
}
