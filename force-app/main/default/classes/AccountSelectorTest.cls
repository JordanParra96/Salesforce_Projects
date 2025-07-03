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
    List<Account> accList = new List<Account>{
      new Account(Name = 'Test Account 1'),
      new Account(Name = 'Test Account 2'),
      new Account(Name = 'Test Account 3')
    };
    insert accList;

    list<Account> accounts = new AccountsSelector()
      .selectById(new Set<Id>{ accList[0].Id, accList[1].Id, accList[2].Id });

    System.assertEquals(3, accounts.size(), 'Should select 3 accounts by ID');
  }
}
