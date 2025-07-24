/**
 * @description Test class for loading accounts from a static resource
 */
@IsTest
private class CSVTests {
  /**
   * @description Test setup method to load test data from a static resource
   */
  @TestSetup
  static void loadTestDataFromStaticResource() {
    // GIVEN
    List<sObject> accounts = Test.loadData(Account.SObjectType, 'accountData');
  }
  /**
   * @description Test method to verify accounts are loaded correctly from the static resource
   */
  @IsTest
  static void testLoadAccountsFromStaticResource() {
    // WHEN
    List<Account> accts = [SELECT ID FROM Account];
    // THEN
    Assert.isTrue(accts.size() == 3, 'Expected 3 accounts');
  }
}
