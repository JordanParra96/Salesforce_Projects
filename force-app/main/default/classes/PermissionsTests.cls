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
    Private_Object__c po = new Private_Object__c(
      Account__c = a.id,
      Notes__c = 'foo'
    );
    insert po;
  }

  /**
   * @description Test method to verify that a user without the permission set cannot access Private_Object__c records.
   */
  @IsTest
  static void testNegativePermissionSet() {
    // GIVEN
    User u = new User(
      ProfileId = new ProfileSelector()
          .selectByName(new Set<String>{ 'Standard User' }, 1)[0]
        .Id,
      LastName = 'last',
      Email = 'Cpt.Awesome@awesomesauce.com',
      UserName = 'Cpt.Awesome.' +
        DateTime.now().getTime() +
        '@awesomesauce.com',
      Alias = 'alias',
      TimeZoneSidKey = 'America/Los_Angeles',
      EmailEncodingKey = 'UTF-8',
      LanguageLocaleKey = 'en_US',
      LocaleSidKey = 'en_US'
    );
    insert u;
    System.runAs(u) {
      // WHEN
      Test.startTest();
      Private_Object__c[] pos = [
        SELECT Id, Account__c, Notes__c
        FROM Private_Object__c
      ];
      Test.stopTest();
      // THEN
      Assert.areEqual(
        0,
        pos.size(),
        'A user without the permission set shouldn\'t see any records'
      );
    }
  }

  /**
   * @description Test method to verify that a user with the permission set can access Private_Object__c records.
   */
  @IsTest
  static void testPositivePermissionSet() {
    // GIVEN
    User u = new User(
      ProfileId = new ProfileSelector()
          .selectByName(new Set<String>{ 'Standard User' }, 1)[0]
        .Id,
      LastName = 'last',
      Email = 'Cpt.Awesome@awesomesauce.com',
      UserName = 'Cpt.Awesome.' +
        DateTime.now().getTime() +
        '@awesomesauce.com',
      Alias = 'alias',
      TimeZoneSidKey = 'America/Los_Angeles',
      EmailEncodingKey = 'UTF-8',
      LanguageLocaleKey = 'en_US',
      LocaleSidKey = 'en_US'
    );
    insert u;

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
      Private_Object__c[] pos = [
        SELECT Id, Account__c, Notes__c
        FROM Private_Object__c
      ];
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
