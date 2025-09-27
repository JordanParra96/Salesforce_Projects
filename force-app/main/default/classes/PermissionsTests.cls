/**
 * @description Test class for PermissionSet Private_Object_Access
 */
@IsTest
private class PermissionsTests {
  /**
   * @description Test setup method to create necessary data for permission tests.
   */
  @TestSetup
  static void testSetup() {
    // GIVEN
    Account a = TestFactory.getAccount('No view For You!', true);
    Map<String, Object> poParams = new Map<String, Object>{
      'account' => a,
      'notes' => 'foo',
      'doInsert' => true
    };
    Private_Object__c po = TestFactory.getPrivateObject(poParams);
  }

  /**
   * @description Test method to verify that a user without the permission set cannot access Private_Object__c records.
   */
  @IsTest
  static void testNegativePermissionSet() {
    // GIVEN
    User u = TestFactory.generateUser('Standard User', true);
    System.runAs(u) {
      // WHEN
      try {
        Test.startTest();
        Private_Object__c[] pos = new PrivateObjectSelector().selectAll();
        Test.stopTest();
        Assert.fail(
          'User without permission set should not access Private_Object__c records'
        );
      } catch (Exception e) {
        // THEN
        System.assert(
          e.getMessage()
            .contains('Permission to access an Private_Object__c denied')
        );
      }
    }
  }

  /**
   * @description Test method to verify that a user with the permission set can access Private_Object__c records.
   */
  @IsTest
  static void testPositivePermissionSet() {
    // GIVEN
    User u = TestFactory.generateUser('Standard User', true);

    PermissionSet ps = [
      SELECT Id
      FROM PermissionSet
      WHERE Name = 'Private_Object_Access'
    ];
    insert new PermissionSetAssignment(
      AssigneeId = u.id,
      PermissionSetId = ps.Id
    );

    System.runAs(u) {
      // WHEN
      Test.startTest();
      Private_Object__c[] pos = new PrivateObjectSelector().selectAll();
      Test.stopTest();
      // THEN
      Assert.areEqual(
        1,
        pos.size(),
        'A user with the permission set should see private object records'
      );
    }
  }
}
