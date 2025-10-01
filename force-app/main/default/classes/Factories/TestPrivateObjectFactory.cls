/**
 * @description A factory class for creating Private_Object__c records for testing purposes.
 */
@isTest
public class TestPrivateObjectFactory {
  /**
   * @description Generates an Account with a specified number of Private_Object__c records.
   * @param numpos The number of Private_Object__c records to create for the Account
   * @param uow The unit of work to use for inserting the Account and Private_Object__c records.
   */
  public static void generateAccountWithPrivateObjects(
    Integer numpos,
    fflib_SObjectUnitOfWork uow
  ) {
    Account a = TestFactory.getAccount('default account ltd', false);
    uow.registerNew(a);

    for (Integer i = 0; i < numpos; i++) {
      Private_Object__c po = new Private_Object__c(
        Name = 'Private Object ' + i,
        Notes__c = 'Private Object ' + i
      );
      uow.registerNew(po, Private_Object__c.Account__c, a);
    }

    uow.commitWork();
  }

  /**
   * @description Generates a Private_Object__c associated with the specified Account.
   * @param params A map containing parameters for the Private_Object__c:
   *               - account: The Account to associate with.
   *               - notes: The notes for the Private_Object__c.
   *               - doInsert: Whether to insert the Private_Object__c into the database.
   *               - uow: The unit of work to use for inserting the Private_Object__c.
   * @return The created Private_Object__c.
   */
  public static Private_Object__c getPrivateObject(Map<String, Object> params) {
    TestFactory.clearData();
    Account acc = (Account) params.get('account');
    String notes = (String) params.get('notes');
    Boolean doInsert = (Boolean) params.get('doInsert');
    fflib_SObjectUnitOfWork uow = (fflib_SObjectUnitOfWork) params.get('uow');

    Private_Object__c po = new Private_Object__c(Notes__c = notes);
    if (doInsert) {
      uow.registerRelationship(po, Private_Object__c.Account__c, acc);
      uow.registerNew(po);
      uow.commitWork();
    }
    return po;
  }
}
