/**
 * @description Test class for the AccountSelector class.
 */
@isTest
private class AccountSelectorTest {
  /**
   * @description Setup method to create test data.
   */
  @TestSetup
  static void makeData() {
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ Account.SObjectType }
    );
    List<Account> accList = new List<Account>{
      new Account(Name = 'Test Account 1'),
      new Account(Name = 'Test Account 2'),
      new Account(Name = 'Test Account 3')
    };
    for (Account acc : accList) {
      uow.registerNew(acc);
    }
    uow.commitWork();
  }

  /**
   * @description Test method for AccountSelector class.
   */
  @isTest
  static void selectById() {
    List<Account> accList = new AccountsSelector().selectAll(3);
    list<Account> accounts = new AccountsSelector()
      .selectById(new Set<Id>{ accList[0].Id, accList[1].Id, accList[2].Id });

    System.assertEquals(3, accounts.size(), 'Should select 3 accounts by ID');
  }

  /**
   * @description Test method for selecting Accounts by name.
   */
  @isTest
  static void selectByName() {
    Set<String> nameSet = new Set<String>{ 'Test Account 1', 'Test Account 2' };
    List<Account> accounts = new AccountsSelector().selectByName(nameSet, 10);

    System.assertEquals(2, accounts.size(), 'Should select 2 accounts by name');
  }

  /**
   * @description Test method for selecting all Accounts.
   */
  @isTest
  static void selectAll() {
    List<Account> accounts = new AccountsSelector().selectAll();

    System.assert(
      accounts.size() >= 3,
      'Should select at least 3 accounts in total'
    );
  }

  /**
   * @description Test method for selecting all Accounts with a limit.
   */
  @isTest
  static void selectAllWithLimit() {
    list<Account> accounts = new AccountsSelector().selectAll(2);
    System.assertEquals(
      2,
      accounts.size(),
      'Should select 2 accounts with limit'
    );
  }
}
