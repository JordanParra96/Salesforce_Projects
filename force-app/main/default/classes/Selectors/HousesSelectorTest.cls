/**
 * @description Test class for the HousesSelector class.
 */
@isTest
private class HousesSelectorTest {
  /**
   * @description Test method for HousesSelector class.
   */
  @isTest
  static void selectById() {
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ House__c.SObjectType }
    );

    List<House__c> houseList = new List<House__c>{
      new House__c(
        Name = 'Test House 1',
        Address__c = '123 Main St',
        State__c = 'CA',
        City__c = 'Los Angeles',
        Zip__c = '90001'
      ),
      new House__c(
        Name = 'Test House 2',
        Address__c = '456 Elm St',
        State__c = 'CA',
        City__c = 'San Francisco',
        Zip__c = '94101'
      ),
      new House__c(
        Name = 'Test House 3',
        Address__c = '789 Oak St',
        State__c = 'CA',
        City__c = 'San Diego',
        Zip__c = '92101'
      )
    };
    for (House__c house : houseList) {
      uow.registerNew(house);
    }

    uow.commitWork();

    List<House__c> houses = new HousesSelector()
      .selectById(
        new Set<Id>{ houseList[0].Id, houseList[1].Id, houseList[2].Id }
      );

    System.assertEquals(3, houses.size(), 'Should select 3 houses by ID');
  }

  /**
   * @description Test method for selecting All Houses.
   */
  @isTest
  static void selectAll() {
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ House__c.SObjectType }
    );

    List<House__c> houseList = new List<House__c>{
      new House__c(
        Name = 'Test House A',
        Address__c = '123 Main St',
        State__c = 'CA',
        City__c = 'Los Angeles',
        Zip__c = '90001'
      ),
      new House__c(
        Name = 'Test House B',
        Address__c = '456 Elm St',
        State__c = 'CA',
        City__c = 'San Francisco',
        Zip__c = '94101'
      )
    };
    for (House__c house : houseList) {
      uow.registerNew(house);
    }

    uow.commitWork();

    List<House__c> houses = new HousesSelector().selectAll(10);

    System.assertEquals(2, houses.size(), 'Should select all houses');
  }
}
