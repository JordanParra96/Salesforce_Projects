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
      Pricebook2.SObjectType,
      PricebookEntry.SObjectType,
      Order.SObjectType,
      OrderItem.SObjectType,
      Task.SObjectType
    }
  );

  /**
   * @description Creates an Account with the specified name.
   * @param name The name of the Account to create.
   * @param doInsert Whether to insert the Account into the database.
   * @return The created Account.
   */
  public static Account getAccount(String name, Boolean doInsert) {
    return TestAccountFactory.getAccount(name, doInsert, uow);
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
    return TestAccountFactory.generateAccounts(numAccounts, doInsert, uow);
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
    return TestAccountFactory.generateAccountsWithNames(names, doInsert, uow);
  }

  /**
   * @description Creates a Contact associated with the specified Account.
   * @param params A map containing parameters for the Contact:
   *               - accountId: The Id of the Account to associate with.
   *               - fname: The first name of the Contact.
   *               - lname: The last name of the Contact.
   *               - doInsert: Whether to insert the Contact into the database.
   * @return The created Contact.
   */
  public static Contact getContact(Map<String, Object> params) {
    return TestContactFactory.getContact(params, uow);
  }

  /**
   * @description Generates an Account with a specified number of Contacts.
   * @param numContacts The number of Contacts to create for the Account.
   */
  public static void generateAccountWithContacts(Integer numContacts) {
    TestContactFactory.generateAccountWithContacts(numContacts, uow);
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
    return TestOpportunityFactory.generateOppsForAccount(
      accountId,
      amount,
      numOpps
    );
  }

  /**
   * @description Generates Tasks for a specified Account.
   * @param params A map containing parameters for the Tasks:
   *               - accountId: The Id of the Account to associate with.
   *               - subjectPrefix: The prefix for the Task subject.
   *               - numTasks: The number of Tasks to create.
   *               - doInsert: Whether to insert the Tasks into the database.
   * @return An array of created Tasks.
   */
  public static Task[] generateTasksForAccount(Map<String, Object> params) {
    params.put('uow', uow);
    return TestTaskFactory.generateTasksForAccount(params);
  }

  /**
   * @description Generates an Account with a specified number of Private Objects.
   * @param numpos The number of Private Objects to create for the Account.
   */
  public static void generateAccountWithPrivateObjects(Integer numpos) {
    TestPrivateObjectFactory.generateAccountWithPrivateObjects(numpos, uow);
  }

  /**
   * @description Generates an Opportunity using parameters.
   * @param params A map containing parameters for the Opportunity:
   *               - account: The Account to associate with.
   *               - name: The name of the Opportunity.
   *               - closeDate: The close date of the Opportunity.
   *               - stageName: The stage name of the Opportunity.
   *               - doInsert: Whether to insert the Opportunity into the database.
   * @return An array of created Opportunity.
   */
  public static Opportunity getOpportunity(Map<String, Object> params) {
    params.put('uow', uow);
    return TestOpportunityFactory.getOpportunity(params);
  }

  /**
   * @description Generates a PricebookEntry associated with the specified Product2 and Pricebook2.
   * @param params A map containing parameters for the PricebookEntry:
   *               - pbId: The Id of the Pricebook2 to associate with.
   *               - product: The Product2 to associate with.
   *               - unitPrice: The unit price for the PricebookEntry.
   *               - isActive: Whether the PricebookEntry is active.
   *               - doInsert: Whether to insert the PricebookEntry into the database.
   * @return The created PricebookEntry.
   */
  public static PricebookEntry getPriceBookEntry(Map<String, Object> params) {
    params.put('uow', uow);
    return TestPricebookFactory.getPriceBookEntry(params);
  }

  /**
   * @description Generates PricebookEntry records using a wrapper class.
   * @param pbeWrapper A PricebookEntryWrapper containing lists of Pricebook2 and Product2 records, and unit price.
   * @param doInsert Whether to insert the PricebookEntry records into the database.
   * @return An array of created PricebookEntry records.
   */
  public static PricebookEntry[] generatePricebookEntries(
    TestPricebookFactory.PricebookEntryWrapper pbeWrapper,
    Boolean doInsert
  ) {
    return TestPricebookFactory.generatePricebookEntries(
      pbeWrapper,
      doInsert,
      uow
    );
  }

  /**
   * @description Generates an Order associated with the specified Account.
   * @param params A map containing parameters for the Order:
   *               - account: The Account to associate with.
   *               - effectiveDate: The effective date of the Order.
   *               - status: The status of the Order.
   *               - pbId: The Id of the Pricebook2 to associate with.
   *               - doInsert: Whether to insert the Order into the database.
   * @return The created Order.
   */
  public static Order getOrder(Map<String, Object> params) {
    params.put('uow', uow);
    return TestOrderFactory.getOrder(params);
  }

  /**
   * @description Generates a Private_Object__c associated with the specified Account.
   * @param params A map containing parameters for the Private_Object__c:
   *               - account: The Account to associate with.
   *               - name: The name of the Private_Object__c.
   *               - description: The description of the Private_Object__c.
   *               - doInsert: Whether to insert the Private_Object__c into the database.
   * @return The created Private_Object__c.
   */
  public static Private_Object__c getPrivateObject(Map<String, Object> params) {
    params.put('uow', uow);
    return TestPrivateObjectFactory.getPrivateObject(params);
  }

  /**
   * @description Generates a User with the specified profile name.
   * @param profileName The name of the Profile for the User.
   * @param doInsert Whether to insert the User into the database.
   * @return The created User.
   */
  public static User generateUser(String profileName, Boolean doInsert) {
    return TestUserFactory.generateUser(profileName, doInsert, uow);
  }

  /**
   * @description Generates a specified number of Houses.
   * @param numHouses The number of Houses to create.
   * @param doInsert Whether to insert the Houses into the database.
   * @return An array of created Houses.
   */
  public static House__c[] generateHouses(Integer numHouses, Boolean doInsert) {
    return TestHouseFactory.generateHouses(numHouses, doInsert, uow);
  }

  /**
   * @description Generates a specified number of Cases.
   * @param numCases The number of Cases to create.
   * @param doInsert Whether to insert the Cases into the database.
   * @return An array of created Cases.
   */
  public static Case[] generateCases(Integer numCases, Boolean doInsert) {
    return TestCaseFactory.generateCases(numCases, doInsert, uow);
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
    return TestProductFactory.generateProducts(numProducts, doInsert, uow);
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
    return TestProductFactory.generateSpecificProducts(
      productCodes,
      doInsert,
      uow
    );
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
    return TestPricebookFactory.generatePricebooks(
      numPricebooks,
      doInsert,
      uow
    );
  }

  /**
   * @description Generates a specified number of OrderItem records.
   * @param numOrderItems The number of OrderItem records to create.
   * @param doInsert Whether to insert the OrderItem records into the database.
   * @return An array of created OrderItem records.
   */
  public static OrderItem[] generateOrderItems(
    Integer numOrderItems,
    Boolean doInsert
  ) {
    return TestOrderFactory.generateOrderItems(numOrderItems, doInsert, uow);
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
        Pricebook2.SObjectType,
        PricebookEntry.SObjectType,
        Order.SObjectType,
        OrderItem.SObjectType,
        Task.SObjectType
      }
    );
  }
}
