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
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ Opportunity.SObjectType }
    );
    List<Account> accounts = TestFactory.generateAccountsWithNames(
      new List<String>{
        'ACME',
        'Test Account',
        'Module Account',
        'Negative Account'
      },
      true
    );

    List<Opportunity> opps = TestFactory.generateOppsForAccount(
      accounts[0].id,
      1000.00,
      5
    );
    uow.registerNew(opps);

    List<Opportunity> highPriorityopps = TestFactory.generateOppsForAccount(
      accounts[1].id,
      1000000.00,
      5
    );
    uow.registerNew(highPriorityopps);

    List<Opportunity> moduleOpps = TestFactory.generateOppsForAccount(
      accounts[2].id,
      9500.00,
      5
    );
    uow.registerNew(moduleOpps);

    List<Opportunity> negativeOpps = TestFactory.generateOppsForAccount(
      accounts[3].id,
      -10.00,
      5
    );
    uow.registerNew(negativeOpps);

    uow.commitWork();
  }

  /**
   * @description Tests the use of TestFactory to create accounts with contacts.
   */
  @IsTest
  static void testPositiveRoundedAveragePrice() {
    // WHEN
    Account acct = new AccountsSelector()
      .selectByName(new Set<String>{ 'ACME' }, 1)[0];
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
   * @description Tests the case where there are no won Opportunities.
   */
  @IsTest
  static void testNoWonOpportunities() {
    // WHEN
    Account acct = new AccountsSelector()
      .selectByName(new Set<String>{ 'Negative Account' }, 1)[0];
    AccountWrapper acctWrapper = new AccountWrapper(acct);
    // THEN
    Test.startTest();
    try {
      acctWrapper.getRoundedAvgPriceOfOpps();
      System.assert(false, 'Expected an AWException to be thrown');
    } catch (AccountWrapper.AWException e) {
      System.assertEquals('No won Opportunities', e.getMessage());
    }
    Test.stopTest();
  }

  /**
   * @description Tests the case where the average price of Opportunities is less than 1000.
   */
  @IsTest
  static void testModulusGreaterThan500() {
    // WHEN
    Account acct = new AccountsSelector()
      .selectByName(new Set<String>{ 'Module Account' }, 1)[0];
    AccountWrapper acctWrapper = new AccountWrapper(acct);
    // THEN
    Test.startTest();
    Assert.areEqual(
      10000.00,
      acctWrapper.getRoundedAvgPriceOfOpps(),
      'Expected to get 10000.00'
    );
    Test.stopTest();
  }

  /**
   * @description Tests the positive case for the isHighPriority method.
   */
  @IsTest
  static void testIsHighPriority() {
    // WHEN
    Account acct = new AccountsSelector()
      .selectByName(new Set<String>{ 'Test Account' }, 1)[0];
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
    Account acct = new AccountsSelector()
      .selectByName(new Set<String>{ 'ACME' }, 1)[0];
    AccountWrapper acctWrapper = new AccountWrapper(acct);
    // THEN
    Test.startTest();
    Assert.isFalse(
      acctWrapper.isHighPriority(),
      'Expected to not be high priority'
    );
    Test.stopTest();
  }

  /**
   * @description Tests the case where the average price of Opportunities is zero.
   */
  @IsTest
  static void testNegativeAccountWrapperAvgPriceOfOpps() {
    // GIVEN
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ Opportunity.SObjectType }
    );

    Account acct = new AccountsSelector().selectAll(1)[0];
    List<Opportunity> opps = new OpportunitiesSelector()
      .selectByAccountId(new Set<Id>{ acct.Id });
    for (Opportunity o : opps) {
      o.Amount = 0;
      uow.registerDirty(o);
    }
    uow.commitWork();
    AccountWrapper acctWrapper = new AccountWrapper(acct);
    // WHEN
    try {
      Test.startTest();
      acctWrapper.getRoundedAvgPriceOfOpps();
      Test.stopTest();
      Assert.fail('An exception should have been thrown');
    } catch (AccountWrapper.AWException e) {
      // THEN
      Assert.isTrue(
        e.getMessage().equalsIgnoreCase('no won opportunities'),
        'Exception message does not match: ' + e.getMessage()
      );
    }
  }
}
