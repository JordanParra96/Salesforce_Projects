/**
 * @description A factory class for creating test House__c records.
 */
@isTest
public class TestHouseFactory {
  /**
   * @description Generates a specified number of House__c records.
   * @param numHouses The number of House__c records to create.
   * @param doInsert Whether to insert the records into the database.
   * @param uow The unit of work to use for inserting the records.
   * @return An array of created House__c records.
   */
  public static House__c[] generateHouses(
    Integer numHouses,
    Boolean doInsert,
    fflib_SObjectUnitOfWork uow
  ) {
    List<House__c> houses = new List<House__c>();
    for (Integer i = 0; i < numHouses; i++) {
      houses.add(
        new House__c(
          Name = 'House ' + i,
          Address__c = '123 Main St ' + i,
          State__c = 'CA',
          City__c = 'City ' + i,
          Zip__c = '9000' + i
        )
      );
    }
    if (doInsert) {
      uow.registerNew(houses);
      uow.commitWork();
    }
    return houses;
  }
}
