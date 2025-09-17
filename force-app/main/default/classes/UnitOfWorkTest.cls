/**
 * @description Unit of Work Test Class
 */
@IsTest
private class UnitOfWorkTest {
  @isTest
  public static void challengeComplete() {
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{
        Account.SObjectType,
        Contact.SObjectType,
        Note.SObjectType
      }
    );

    for (Integer i = 0; i < 100; i++) {
      // Create an Account
      Account acc = new Account(Name = 'Test Account ' + i);
      uow.registerNew(acc);
      for (Integer j = 0; j < 5; j++) {
        // Create a Contact
        Contact c = new Contact(LastName = 'Test Contact ' + i + '_' + j);
        uow.registerNew(c, Contact.AccountId, acc);
        // Create a Note
        Note n = new Note(
          Title = 'Test Note ' + i + '_' + j,
          Body = 'This is a test body.'
        );
        uow.registerNew(n, Note.parentId, acc);
      }
    }
    // Commit the Unit Of Work
    uow.commitWork();
    System.assertEquals(100, new AccountsSelector().selectAll().size());
    System.assertEquals(500, [SELECT Id FROM Contact].size());
    System.assertEquals(500, [SELECT Id FROM Note].size());
  }
}
