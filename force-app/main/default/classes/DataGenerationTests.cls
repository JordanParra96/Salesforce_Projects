/**
 * @description Tests for data generation utilities.
 */
@IsTest
private class DataGenerationTests {
  /**
   * @description Sets up test data for the tests in this class.
   * This method creates an Account, a Contact, and an Opportunity.
   */
  @TestSetup
  static void dataCreation() {
    // GIVEN
    Account a = TestFactory.getAccount('Muddy Waters Inc.', true);
    Map<String, Object> contactParams = new Map<String, Object>{
      'account' => a,
      'fname' => 'Muddy',
      'lname' => 'Waters',
      'doInsert' => true
    };
    Contact c = TestFactory.getContact(contactParams);
    Opportunity opp = new Opportunity();
    opp.name = 'Long lost record';
    opp.accountId = a.id;
    opp.closeDate = Date.today().addDays(14);
    opp.stageName = 'prospecting';
    insert opp;
  }

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
    accts = new AccountsSelector().selectAll();
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
    accts = new AccountsSelector().selectAll();
    contacts = [SELECT Id FROM Contact];
    Test.stopTest();
    // THEN
    Assert.isTrue(
      accts.size() > 0,
      'Was expecting to find at least one account'
    );
    Assert.areEqual(6, contacts.size(), 'Was expecting to find 5 contacts');
  }

  /**
   * @description Tests the generation of Opportunities for an Account.
   */
  @IsTest
  static void testAtTestSetupMethodsRule() {
    // WHEN
    List<Opportunity> opps = new OpportunitiesSelector().selectAll();
    // THEN
    Assert.areEqual(1, opps.size(), 'Expected test to find a single Opp');
  }
}
