/**
 * @description A factory class for creating test Contact records associated with Accounts.
 */
@isTest
public class TestContactFactory {
  /**
   * @description Creates a Contact associated with the specified Account.
   * @param params A map containing parameters for the Contact:
   *               - accountId: The Id of the Account to associate with.
   *               - fname: The first name of the Contact.
   *               - lname: The last name of the Contact.
   * *             - doInsert: Whether to insert the Contact into the database.
   * @param uow The unit of work to use for inserting the Contact.
   * @return The created Contact.
   */
  public static Contact getContact(
    Map<String, Object> params,
    fflib_SObjectUnitOfWork uow
  ) {
    TestFactory.clearData();
    Account acc = (Account) params.get('account');
    String firstName = (String) params.get('fname');
    String lastName = (String) params.get('lname');
    Boolean doInsert = (Boolean) params.get('doInsert');

    Contact c = new Contact(FirstName = firstName, LastName = lastName);
    if (doInsert) {
      uow.registerRelationship(c, Contact.AccountId, acc);
      uow.registerNew(c);
      uow.commitWork();
    }
    return c;
  }

  /**
   * @description Generates an Account with a specified number of Contacts.
   * @param numContacts The number of Contacts to create for the Account.
   * @param uow The unit of work to use for inserting the Account and Contacts.
   */
  public static void generateAccountWithContacts(
    Integer numContacts,
    fflib_SObjectUnitOfWork uow
  ) {
    TestFactory.clearData();
    Account a = TestFactory.getAccount('default account ltd', true);
    List<Contact> contacts = new List<Contact>();
    for (Integer i = 0; i < numContacts; i++) {
      String contactName = 'contact' + i;
      Map<String, Object> contactParams = new Map<String, Object>{
        'account' => a,
        'fname' => contactName,
        'lname' => contactName,
        'doInsert' => false
      };
      uow.registerRelationship(
        getContact(contactParams, uow),
        Contact.AccountId,
        a
      );
      contacts.add(getContact(contactParams, uow));
    }
    uow.registerNew(contacts);
    uow.commitWork();
  }
}
