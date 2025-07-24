/**
 * @description Test class for MyDataGeneration
 */
@isTest
private class MyDataGenerationTests {
  /**
   * @description Test setup method to load test data from a static resource
   */
  @TestSetup
  static void loadTestDataFromStaticResource() {
    // GIVEN
    List<sObject> accounts = Test.loadData(
      Account.SObjectType,
      'otherAccountData'
    );
  }
  /**
   * @description Test method to verify accounts are loaded correctly from the static resource
   */
  @IsTest
  static void testLoadOtherAccountsFromStaticResource() {
    // WHEN
    List<Account> accts = [SELECT ID FROM Account];
    // THEN
    Assert.isTrue(accts.size() == 15, 'Expected 15 accounts');
  }
}
