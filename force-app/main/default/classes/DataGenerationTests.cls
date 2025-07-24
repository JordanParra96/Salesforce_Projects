/**
 * @description Tests for data generation utilities.
 */
@IsTest
private class DataGenerationTests {
  /**
   * @description Tests the brute force account creation method.
   */
  @IsTest
  static void testBruteForceAccountCreation() {
    // GIVEN
    List<Account> accts;
    Account a = new Account(name = 'McTesterson LLC');
    insert a;
    // WHEN
    Test.startTest();
    accts = [SELECT Id FROM Account];
    Test.stopTest();
    // THEN
    Assert.isTrue(
      accts.size() > 0,
      'Was expecting to find at least one account'
    );
  }

  /**
   * @description Tests the use of TestFactory to create accounts with contacts.
   */
  @IsTest
  static void testUseTestFactoryToCreateAccountsWithContacts() {
    // GIVEN
    List<Account> accts;
    List<Contact> contacts;
    TestFactory.generateAccountWithContacts(5);
    // WHEN
    Test.startTest();
    accts = [SELECT Id FROM Account];
    contacts = [SELECT Id FROM Contact];
    Test.stopTest();
    // THEN
    Assert.isTrue(
      accts.size() > 0,
      'Was expecting to find at least one account'
    );
    Assert.areEqual(5, contacts.size(), 'Was expecting to find 5 contacts');
  }
}
