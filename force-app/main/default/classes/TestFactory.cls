/**
 * @description Factory class for generating test data.
 * This class provides methods to create Accounts, Contacts, Opportunities,
 * and Users for testing purposes.
 */
@isTest
public class TestFactory {
  /**
   * @description Creates an Account with the specified name.
   * @param name The name of the Account to create.
   * @param doInsert Whether to insert the Account into the database.
   * @return The created Account.
   */
  public static Account getAccount(String name, Boolean doInsert) {
    Account a = new Account(name = name);
    if (doInsert) {
      insert a;
    }
    return a;
  }

  /**
   * @description Creates a Contact associated with the specified Account.
   * @param params A map containing parameters for the Contact:
   *               - accountId: The Id of the Account to associate with.
   *               - fname: The first name of the Contact.
   *               - lname: The last name of the Contact.
   * *             - doInsert: Whether to insert the Contact into the database.
   * @return The created Contact.
   */
  public static Contact getContact(Map<String, Object> params) {
    Id accountId = (Id) params.get('accountId');
    String firstName = (String) params.get('fname');
    String lastName = (String) params.get('lname');
    Boolean doInsert = (Boolean) params.get('doInsert');

    Contact c = new Contact(
      firstName = firstName,
      lastName = lastName,
      accountId = accountId
    );
    if (doInsert) {
      insert c;
    }
    return c;
  }

  /**
   * @description Generates an Account with a specified number of Contacts.
   * @param numContacts The number of Contacts to create for the Account.
   */
  public static void generateAccountWithContacts(Integer numContacts) {
    Account a = getAccount('default account ltd', true);
    List<Contact> contacts = new List<Contact>();
    for (Integer i = 0; i < numContacts; i++) {
      String contactName = 'contact' + i;
      Map<String, Object> contactParams = new Map<String, Object>{
        'accountId' => a.Id,
        'fname' => contactName,
        'lname' => contactName,
        'doInsert' => false
      };
      contacts.add(getContact(contactParams));
    }
    insert contacts;
  }

  /**
   * @description Generates Opportunities for a specified Account.
   * @param accountId The Id of the Account to associate with the Opportunities.
   * @param amount The amount for each Opportunity.
   * @param numOpps The number of Opportunities to create.
   * @return A list of created Opportunities.
   */
  public static Opportunity[] generateOppsForAccount(
    id accountId,
    Decimal amount,
    Integer numOpps
  ) {
    List<Opportunity> opps = new List<Opportunity>();
    for (Integer i = 0; i < numOpps; i++) {
      Opportunity o = new Opportunity();
      o.name = 'Account ' + i;
      o.accountId = accountid;
      o.amount = amount;
      o.closeDate = Date.today().addDays(5);
      o.stageName = 'Prospecting';
      opps.add(o);
    }
    return opps;
  }

  /**
   * @description Generates a User with the specified profile name.
   * @param profileName The name of the Profile for the User.
   * @return The created User.
   */
  public static User generateUser(String profileName) {
    UserRole userRole = new UserRole(
      DeveloperName = 'TestingTeam',
      Name = 'Testing Team'
    );
    insert userRole;
    User u = new User(
      ProfileId = [SELECT Id FROM Profile WHERE Name = :profileName]
      .Id,
      LastName = 'last',
      Email = 'Cpt.Awesome@awesomesauce.com',
      Username = 'Cpt.Awesome.' +
        DateTime.now().getTime() +
        '@awesomesauce.com',
      CompanyName = 'Testing Co',
      Title = 'Captian',
      Alias = 'alias',
      TimeZoneSidKey = 'America/Los_Angeles',
      EmailEncodingKey = 'UTF-8',
      LanguageLocaleKey = 'en_US',
      LocaleSidKey = 'en_US',
      UserRoleId = userRole.Id
    );
    insert u;
    return u;
  }
}
