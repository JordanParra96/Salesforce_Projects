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
    List<Account> accList = new List<Account>{
      new Account(Name = 'Test 1', Description = 'Hello World'),
      new Account(Name = 'Test 2', Description = 'Domain classes rock!'),
      new Account(Name = 'Test 3', Description = ''),
      new Account(Name = 'Test 4', Description = null)
    };
    // Register accounts for creation
    for (Account acc : accList) {
      uow.registerNew(acc);
    }
    Test.startTest();
    uow.commitWork();
    Test.stopTest();
    Account testAccount = [
      SELECT Id, Description
      FROM Account
      WHERE Name = 'Test 2'
      LIMIT 1
    ];
    Assert.areEqual(
      'Domain classes rock!',
      testAccount.Description,
      'Description should be set to "Domain classes rock!"'
    );
  }

  /**
   * @description Test method for Accounts domain class before update.
   */
  @isTest
  static void onBeforeUpdate() {
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uowInsert = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ Account.SObjectType }
    );
    List<Account> accList = new List<Account>{
      new Account(Name = 'Test 1', Description = 'Hello World'),
      new Account(Name = 'Test 2', Description = 'Domain classes rock!'),
      new Account(Name = 'Test 3', Description = ''),
      new Account(Name = 'Test 4', Description = null)
    };
    // Insert accounts
    for (Account acc : accList) {
      uowInsert.registerNew(acc);
    }

    uowInsert.commitWork();
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
    List<Account> updatedAccounts = [
      SELECT Id, AnnualRevenue
      FROM Account
      WHERE Name IN ('Test 1', 'Test 2', 'Test 3', 'Test 4')
    ];
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
}
