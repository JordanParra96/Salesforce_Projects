/**
 * @description Factory class for generating test data.
 * This class provides methods to create Accounts, Contacts, Opportunities,
 * and Users for testing purposes.
 */
@isTest
public class TestFactory {
  private static fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
    new List<Schema.SObjectType>{
      Account.SObjectType,
      Contact.SObjectType,
      House__c.SObjectType,
      User.SObjectType,
      Case.SObjectType,
      Private_Object__c.SObjectType,
      Product2.SObjectType,
      Opportunity.SObjectType,
      Pricebook2.SObjectType
    }
  );
  /**
   * @description Creates an Account with the specified name.
   * @param name The name of the Account to create.
   * @param doInsert Whether to insert the Account into the database.
   * @return The created Account.
   */
  public static Account getAccount(String name, Boolean doInsert) {
    Account a = new Account(name = name);
    if (doInsert) {
      uow.registerNew(a);
      uow.commitWork();
    }
    return a;
  }

  /**
   * @description Generates a specified number of Accounts.
   * @param numAccounts The number of Accounts to create.
   * @param doInsert Whether to insert the Accounts into the database.
   * @return An array of created Accounts.
   */
  public static Account[] generateAccounts(
    Integer numAccounts,
    Boolean doInsert
  ) {
    List<Account> accounts = new List<Account>();
    for (Integer i = 0; i < numAccounts; i++) {
      accounts.add(new Account(name = 'Test ' + i));
    }
    if (doInsert) {
      uow.registerNew(accounts);
      uow.commitWork();
    }
    return accounts;
  }

  /**
   * @description Generates Accounts with specified names.
   * @param names A list of names for the Accounts to create.
   * @param doInsert Whether to insert the Accounts into the database.
   * @return An array of created Accounts.
   */
  public static Account[] generateAccountsWithNames(
    List<String> names,
    Boolean doInsert
  ) {
    List<Account> accounts = new List<Account>();
    for (String name : names) {
      accounts.add(new Account(name = name));
    }
    if (doInsert) {
      uow.registerNew(accounts);
      uow.commitWork();
    }
    return accounts;
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
    clearData();
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
   */
  public static void generateAccountWithContacts(Integer numContacts) {
    clearData();
    Account a = getAccount('default account ltd', true);
    List<Contact> contacts = new List<Contact>();
    for (Integer i = 0; i < numContacts; i++) {
      String contactName = 'contact' + i;
      Map<String, Object> contactParams = new Map<String, Object>{
        'account' => a,
        'fname' => contactName,
        'lname' => contactName,
        'doInsert' => false
      };
      uow.registerRelationship(getContact(contactParams), Contact.AccountId, a);
      contacts.add(getContact(contactParams));
    }
    uow.registerNew(contacts);
    uow.commitWork();
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
   * @description Generates an Account with a specified number of Private_Object__c records.
   * @param numpos The number of Private_Object__c records to create for the Account
   */
  public static void generateAccountWithPrivateObjects(Integer numpos) {
    Account a = getAccount('default account ltd', false);
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
   * @description Generates Opportunity for a specified Account using parameters.
   * @param params A map containing parameters for the Opportunity:
   *               - account: The Account to associate with.
   *               - name: The name of the Opportunity.
   *               - closeDate: The close date of the Opportunity.
   *               - stageName: The stage name of the Opportunity.
   *               - doInsert: Whether to insert the Opportunity into the database.
   * @return An array of created Opportunity.
   */
  public static Opportunity getOpportunity(Map<String, Object> params) {
    clearData();
    Account acc = (Account) params.get('account');
    String name = (String) params.get('name');
    Date closeDate = (Date) params.get('closeDate');
    String stageName = (String) params.get('stageName');
    Boolean doInsert = (Boolean) params.get('doInsert');

    Opportunity opp = new Opportunity(
      name = name,
      closeDate = closeDate,
      stageName = stageName
    );
    if (doInsert) {
      uow.registerRelationship(opp, Opportunity.AccountId, acc);
      uow.registerNew(opp);
      uow.commitWork();
    }
    return opp;
  }

  /**
   * @description Generates a Private_Object__c associated with the specified Account.
   * @param params A map containing parameters for the Private_Object__c:
   *               - account: The Account to associate with.
   *               - notes: The notes for the Private_Object__c.
   *               - doInsert: Whether to insert the Private_Object__c into the database.
   * @return The created Private_Object__c.
   */
  public static Private_Object__c getPrivateObject(Map<String, Object> params) {
    clearData();
    Account acc = (Account) params.get('account');
    String notes = (String) params.get('notes');
    Boolean doInsert = (Boolean) params.get('doInsert');

    Private_Object__c po = new Private_Object__c(Notes__c = notes);
    if (doInsert) {
      uow.registerRelationship(po, Private_Object__c.Account__c, acc);
      uow.registerNew(po);
      uow.commitWork();
    }
    return po;
  }

  /**
   * @description Generates a User with the specified profile name.
   * @param profileName The name of the Profile for the User.
   * @param doInsert Whether to insert the User into the database.
   * @return The created User.
   */
  public static User generateUser(String profileName, Boolean doInsert) {
    User u = new User(
      ProfileId = new ProfileSelector()
          .selectByName(new Set<String>{ profileName }, 1)[0]
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
      LocaleSidKey = 'en_US'
    );
    if (doInsert) {
      uow.registerNew(u);
    }
    uow.commitWork();
    return u;
  }

  /**
   * @description Generates a specified number of House__c records.
   * @param numHouses The number of House__c records to create.
   * @param doInsert Whether to insert the records into the database.
   * @return An array of created House__c records.
   */
  public static House__c[] generateHouses(Integer numHouses, Boolean doInsert) {
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

  /**
   * @description Generates a specified number of Cases.
   * @param numCases The number of Cases to create.
   * @param doInsert Whether to insert the Cases into the database.
   * @return An array of created Cases.
   */
  public static Case[] generateCases(Integer numCases, Boolean doInsert) {
    List<Case> cases = new List<Case>();
    for (Integer i = 0; i < numCases; i++) {
      cases.add(new Case(Subject = 'Case ' + i, Status = 'New'));
    }
    if (doInsert) {
      uow.registerNew(cases);
      uow.commitWork();
    }
    return cases;
  }

  /**
   * @description Generates a specified number of Product2 records.
   * @param numProducts The number of Product2 records to create.
   * @param doInsert Whether to insert the Product2 records into the database.
   * @return An array of created Product2 records.
   */
  public static Product2[] generateProducts(
    Integer numProducts,
    Boolean doInsert
  ) {
    List<Product2> products = new List<Product2>();
    for (Integer i = 0; i < numProducts; i++) {
      products.add(
        new Product2(
          Name = 'Product ' + i,
          ProductCode = 'PCode' + i,
          IsActive = true
        )
      );
    }
    if (doInsert) {
      uow.registerNew(products);
      uow.commitWork();
    }
    return products;
  }

  /**
   * @description Generates Product2 records with specified product codes.
   * @param productCodes A list of product codes for the Product2 records to create.
   * @param doInsert Whether to insert the Product2 records into the database.
   * @return An array of created Product2 records.
   */
  public static Product2[] generateSpecificProducts(
    List<String> productCodes,
    Boolean doInsert
  ) {
    clearData();
    List<Product2> products = new List<Product2>();
    for (String code : productCodes) {
      products.add(
        new Product2(
          Name = 'Product ' + code,
          ProductCode = code,
          IsActive = true
        )
      );
    }
    if (doInsert) {
      uow.registerNew(products);
      uow.commitWork();
    }
    return products;
  }

  /**
   * @description Generates a specified number of Pricebook2 records.
   * @param numPricebooks The number of Pricebook2 records to create.
   * @param doInsert Whether to insert the Pricebook2 records into the database.
   * @return An array of created Pricebook2 records.
   */
  public static Pricebook2[] generatePricebooks(
    Integer numPricebooks,
    Boolean doInsert
  ) {
    clearData();
    List<Pricebook2> pricebooks = new List<Pricebook2>();
    for (Integer i = 0; i < numPricebooks; i++) {
      pricebooks.add(new Pricebook2(Name = 'Pricebook ' + i, IsActive = true));
    }
    if (doInsert) {
      uow.registerNew(pricebooks);
      uow.commitWork();
    }
    return pricebooks;
  }

  /**
   * @description Clears the test data by reinitializing the Unit of Work.
   */
  public static void clearData() {
    uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{
        Account.SObjectType,
        Contact.SObjectType,
        House__c.SObjectType,
        User.SObjectType,
        Case.SObjectType,
        Private_Object__c.SObjectType,
        Product2.SObjectType,
        Opportunity.SObjectType,
        Pricebook2.SObjectType
      }
    );
  }
}
