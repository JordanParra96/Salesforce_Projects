/**
 * @description Test class for Accounts domain class.
 */
@isTest
private class AccountsTest {
  /**
   * @description Test method for Accounts domain class constructor.
   */
  @isTest
  static void onApplyDefaults() {
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ Account.SObjectType }
    );
    List<Account> accList = TestFactory.generateAccounts(4, false);
    // Register accounts for creation
    for (Account acc : accList) {
      uow.registerNew(acc);
    }
    Test.startTest();
    uow.commitWork();
    Test.stopTest();

    List<Account> testAccounts = new AccountsSelector()
      .selectByName(new Set<String>{ 'Test 2' }, 1);

    Assert.areEqual(
      'Domain classes rock!',
      testAccounts[0].Description,
      'Description should be set to "Domain classes rock!"'
    );
  }

  /**
   * @description Test method for Accounts domain class before update.
   */
  @isTest
  static void onBeforeUpdate() {
    List<Account> accList = TestFactory.generateAccounts(4, true);

    Test.startTest();
    //Create a new Unit Of Work for updates
    fflib_SObjectUnitOfWork uowUpdate = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ Account.SObjectType }
    );
    for (Account acc : accList) {
      acc.Description += ' Updated';
      uowUpdate.registerDirty(acc);
    }
    uowUpdate.commitWork();
    Test.stopTest();

    List<Account> updatedAccounts = new AccountsSelector()
      .selectByName(
        new Set<String>{ 'Test 0', 'Test 1', 'Test 2', 'Test 3' },
        10
      );

    Assert.isTrue(
      updatedAccounts.size() == 4,
      'All accounts should be updated'
    );
    Assert.isTrue(
      updatedAccounts[0].AnnualRevenue != null,
      'AnnualRevenue should not be null for Test 1'
    );
    Assert.isTrue(
      updatedAccounts[1].AnnualRevenue != null,
      'AnnualRevenue should not be null for Test 2'
    );
    Assert.isTrue(
      updatedAccounts[2].AnnualRevenue != null,
      'AnnualRevenue should not be null for Test 3'
    );
    Assert.isTrue(
      updatedAccounts[3].AnnualRevenue != null,
      'AnnualRevenue should not be null for Test 4'
    );
    Assert.areEqual(
      updatedAccounts[0].AnnualRevenue,
      accList[0].Description.getLevenshteinDistance('Domain classes rock!'),
      'AnnualRevenue for Test 1 should match the Levenshtein distance'
    );
    Assert.areEqual(
      updatedAccounts[1].AnnualRevenue,
      accList[1].Description.getLevenshteinDistance('Domain classes rock!'),
      'AnnualRevenue for Test 2 should match the Levenshtein distance'
    );
    Assert.areEqual(
      updatedAccounts[2].AnnualRevenue,
      accList[2].Description.getLevenshteinDistance('Domain classes rock!'),
      'AnnualRevenue for Test 3 should match the Levenshtein distance'
    );
    Assert.areEqual(
      updatedAccounts[3].AnnualRevenue,
      accList[3].Description.getLevenshteinDistance('Domain classes rock!'),
      'AnnualRevenue for Test 4 should match the Levenshtein distance'
    );
  }

  /**
   * @description Test method for Accounts domain class before delete.
   */
  @isTest
  static void onBeforeDelete() {
    // GIVEN
    Account acct = TestFactory.getAccount('ACME', true);
    Map<String, Object> params = new Map<String, Object>{
      'name' => 'Big Deal',
      'stageName' => 'Prospecting',
      'closeDate' => Date.today().addDays(30),
      'account' => acct,
      'doInsert' => true
    };
    Opportunity opp = TestFactory.getOpportunity(params);

    // WHEN
    Test.startTest();
    Database.DeleteResult result = Database.delete(acct, false);
    Test.stopTest();

    // THEN
    Assert.isFalse(result.isSuccess());
    Assert.isTrue(result.getErrors().size() > 0);
    Assert.areEqual(
      'Cannot delete account with related opportunities.',
      result.getErrors()[0].getMessage()
    );
  }
}
