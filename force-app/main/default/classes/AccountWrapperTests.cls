/**
 * @description Tests for the AccountWrapper class.
 */
@IsTest
private class AccountWrapperTests {
  /**
   * @description Test setup to create necessary test data.
   */
  @TestSetup
  static void loadTestData() {
    // GIVEN
    List<Account> accounts = new List<Account>();
    Account acme = new Account(Name = 'ACME');
    accounts.add(acme);
    Account testAccount = new Account(Name = 'Test Account');
    accounts.add(testAccount);
    insert accounts;
    List<Opportunity> opps = TestFactory.generateOppsForAccount(
      accounts[0].id,
      1000.00,
      5
    );
    insert opps;
    List<Opportunity> highPriorityopps = TestFactory.generateOppsForAccount(
      accounts[1].id,
      1000000.00,
      5
    );
    insert highPriorityopps;
  }

  /**
   * @description Tests the use of TestFactory to create accounts with contacts.
   */
  @IsTest
  static void testPositiveRoundedAveragePrice() {
    // WHEN
    Account acct = [SELECT Id FROM Account WHERE Name = 'ACME' LIMIT 1];
    AccountWrapper acctWrapper = new AccountWrapper(acct);
    // THEN
    Test.startTest();
    Assert.areEqual(
      1000.00,
      acctWrapper.getRoundedAvgPriceOfOpps(),
      'Expected to get 1000.00'
    );
    Test.stopTest();
  }

  /**
   * @description Tests the positive case for the isHighPriority method.
   */
  @IsTest
  static void testIsHighPriority() {
    // WHEN
    Account acct = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];
    AccountWrapper acctWrapper = new AccountWrapper(acct);
    // THEN
    Test.startTest();
    Assert.isTrue(acctWrapper.isHighPriority(), 'Expected to be high priority');
    Test.stopTest();
  }

  /**
   * @description Tests the negative case for the isHighPriority method.
   */
  @IsTest
  static void testNegativeIsHighPriority() {
    // WHEN
    Account acct = [SELECT Id FROM Account WHERE Name = 'ACME' LIMIT 1];
    AccountWrapper acctWrapper = new AccountWrapper(acct);
    // THEN
    Test.startTest();
    Assert.isFalse(
      acctWrapper.isHighPriority(),
      'Expected to not be high priority'
    );
    Test.stopTest();
  }
}
