/**
 * @description Test class for the AccountSelector class.
 */
@isTest
private class AccountSelectorTest {
  /**
   * @description Test method for AccountSelector class.
   */
  @isTest
  static void selectById() {
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

    list<Account> accounts = new AccountsSelector()
      .selectById(new Set<Id>{ accList[0].Id, accList[1].Id, accList[2].Id });

    System.assertEquals(3, accounts.size(), 'Should select 3 accounts by ID');
  }

  /**
   * @description Test method for selecting Accounts by name.
   */
  @isTest
  static void selectByName() {
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ Account.SObjectType }
    );

    List<Account> accList = new List<Account>{
      new Account(Name = 'Test Account A'),
      new Account(Name = 'Test Account B'),
      new Account(Name = 'Test Account C')
    };
    for (Account acc : accList) {
      uow.registerNew(acc);
    }

    uow.commitWork();

    Set<String> nameSet = new Set<String>{ 'Test Account A', 'Test Account B' };
    List<Account> accounts = new AccountsSelector().selectByName(nameSet, 10);

    System.assertEquals(2, accounts.size(), 'Should select 2 accounts by name');
  }
}
