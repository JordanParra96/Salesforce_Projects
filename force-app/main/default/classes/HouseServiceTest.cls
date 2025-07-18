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
    // Create unit of work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ House__c.SObjectType, User.SObjectType }
    );
    Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
    User usr = new User(
      LastName = 'TEST',
      FirstName = 'Fail',
      Alias = 'ftest',
      Email = 'f.test@asdf.com',
      Username = 'f.test@asdf.com',
      ProfileId = p.id,
      TimeZoneSidKey = 'GMT',
      LanguageLocaleKey = 'en_US',
      EmailEncodingKey = 'UTF-8',
      LocaleSidKey = 'en_US'
    );
    // Register user for creation
    uow.registerNew(usr);

    List<House__c> houses = new List<House__c>{
      new House__c(
        Name = 'House 1',
        Address__c = '123 Main St',
        State__c = 'CA',
        City__c = 'LA',
        Zip__c = '90001'
      ),
      new House__c(
        Name = 'House 2',
        Address__c = '456 Oak Ave',
        State__c = 'CA',
        City__c = 'SF',
        Zip__c = '94101'
      ),
      new House__c(
        Name = 'House 3',
        Address__c = '789 Pine Rd',
        State__c = 'CA',
        City__c = 'SD',
        Zip__c = '92101'
      )
    };
    // Register houses for creation
    for (House__c h : houses) {
      uow.registerNew(h);
    }
    // Insert user and houses
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
    User testUser = [SELECT Id FROM User WHERE LastName = 'TEST' LIMIT 1];
    System.runAs(testUser) {
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
