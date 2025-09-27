/**
 * @description Test class for PrivateObjectSelector
 */
@isTest
private class PrivateObjectSelectorTest {
  /**
   * @description Setup method to create test data.
   */
  @TestSetup
  static void makeData() {
    TestFactory.generateAccountWithPrivateObjects(3);
  }

  /**
   * @description Test method for PrivateObjectSelector class.
   */
  @isTest
  static void selectById() {
    List<Private_Object__c> poList = new PrivateObjectSelector().selectAll(3);
    list<Private_Object__c> pos = new PrivateObjectSelector()
      .selectById(new Set<Id>{ poList[0].Id, poList[1].Id, poList[2].Id });

    System.assertEquals(
      3,
      pos.size(),
      'Should select 3 Private_Object__c records by ID'
    );
  }

  /**
   * @description Test method for selecting Private_Object__c records by name.
   */
  @isTest
  static void selectByName() {
    Set<String> nameSet = new Set<String>{
      'Private Object 0',
      'Private Object 1'
    };
    List<Private_Object__c> pos = new PrivateObjectSelector()
      .selectByName(nameSet, 10);

    System.assertEquals(
      2,
      pos.size(),
      'Should select 2 Private_Object__c records by name'
    );
  }

  /**
   * @description Test method for selecting all Private_Object__c records.
   */
  @isTest
  static void selectAll() {
    List<Private_Object__c> pos = new PrivateObjectSelector().selectAll();

    System.assert(
      pos.size() >= 3,
      'Should select at least 3 Private_Object__c records in total'
    );
  }

  /**
   * @description Test method for selecting all Private_Object__c records with a limit.
   */
  @isTest
  static void selectAllWithLimit() {
    List<Private_Object__c> pos = new PrivateObjectSelector().selectAll(2);

    System.assertEquals(
      2,
      pos.size(),
      'Should select exactly 2 Private_Object__c records due to the limit'
    );
  }
}
