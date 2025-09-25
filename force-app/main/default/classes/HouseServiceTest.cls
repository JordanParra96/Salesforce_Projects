/**
 * @description Service class for handling House__c records.
 */
@isTest
private class HouseServiceTest {
  /**
   * @description Sets up the test environment by creating a user and inserting House__c records.
   */
  @testSetup
  static void setup() {
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ House__c.SObjectType, User.SObjectType }
    );

    User usr = TestFactory.generateUser('Standard User', false);
    uow.registerNew(usr);

    List<House__c> houses = TestFactory.generateHouses(3, false);
    for (House__c h : houses) {
      uow.registerNew(h);
    }

    uow.commitWork();
  }
  /**
   * @description Tests the getRecords method of HouseService.
   * It verifies that the method returns records and that the fields are populated.
   */
  @isTest
  static void testGetRecordsReturnsRecords() {
    // Act: Call the method
    Test.startTest();
    List<House__c> result = HouseService.getRecords();
    Test.stopTest();

    // Assert: Check that records are returned and fields are populated
    System.assertEquals(3, result.size(), 'Should return 3 records');
    for (House__c h : result) {
      System.assertNotEquals(null, h.Id, 'Id should not be null');
      System.assertNotEquals(null, h.Name, 'Name should not be null');
      System.assertNotEquals(
        null,
        h.Address__c,
        'Address__c should not be null'
      );
      System.assertNotEquals(null, h.State__c, 'State__c should not be null');
      System.assertNotEquals(null, h.City__c, 'City__c should not be null');
      System.assertNotEquals(null, h.Zip__c, 'Zip__c should not be null');
    }
  }
  /**
   * @description Tests the getRecords method of HouseService to ensure it handles exceptions.
   * It simulates a scenario where a QueryException is thrown.
   */
  @isTest
  static void testGetRecordsThrownException() {
    List<User> testUsers = new UsersSelector()
      .selectByLastname(new Set<String>{ 'last' }, 1);
    System.runAs(testUsers[0]) {
      // Simulate a scenario where a QueryException is thrown
      Test.startTest();
      try {
        List<House__c> result = HouseService.getRecords();
        Test.stopTest();
        System.assert(false, 'Expected an exception to be thrown');
      } catch (AuraHandledException e) {
        // Assert: Check that the exception message is as expected
        System.assert(true, 'Exception was thrown as expected');
      }
    }
  }
}
