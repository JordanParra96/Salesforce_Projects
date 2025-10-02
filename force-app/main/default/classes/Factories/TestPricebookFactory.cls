/**
 * @description A factory class for creating test PricebookEntry and Pricebook2 records.
 */
@isTest
public class TestPricebookFactory {
  /**
   * @description Generates a PricebookEntry associated with the specified Product2 and Pricebook2.
   * @param params A map containing parameters for the PricebookEntry:
   *               - pbId: The Id of the Pricebook2 to associate with.
   *               - product: The Product2 to associate with.
   *               - unitPrice: The unit price for the PricebookEntry.
   *               - isActive: Whether the PricebookEntry is active.
   *               - doInsert: Whether to insert the PricebookEntry into the database.
   *               - uow: The unit of work to use for inserting the PricebookEntry.
   * @return The created PricebookEntry.
   */
  public static PricebookEntry getPriceBookEntry(Map<String, Object> params) {
    TestFactory.clearData();
    String pbId = (String) params.get('pbId');
    Product2 p = (Product2) params.get('product');
    Decimal unitPrice = (Decimal) params.get('unitPrice');
    Boolean isActive = (Boolean) params.get('isActive');
    Boolean doInsert = (Boolean) params.get('doInsert');
    fflib_SObjectUnitOfWork uow = (fflib_SObjectUnitOfWork) params.get('uow');

    PricebookEntry pbe = new PricebookEntry(
      Pricebook2Id = pbId,
      UnitPrice = unitPrice,
      IsActive = true
    );
    if (doInsert) {
      uow.registerRelationship(pbe, PricebookEntry.Product2Id, p);
      uow.registerNew(pbe);
      uow.commitWork();
    }
    return pbe;
  }

  /**
   * @description Generates a specified number of Pricebook2 records.
   * @param numPricebooks The number of Pricebook2 records to create.
   * @param doInsert Whether to insert the Pricebook2 records into the database.
   * @param uow The unit of work to use for inserting the Pricebook2 records.
   * @return An array of created Pricebook2 records.
   */
  public static Pricebook2[] generatePricebooks(
    Integer numPricebooks,
    Boolean doInsert,
    fflib_SObjectUnitOfWork uow
  ) {
    TestFactory.clearData();
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
   * @description Generates PricebookEntry records for each combination of the provided Pricebook2 and Product2 records.
   * @param pbeWrapper A PricebookEntryWrapper containing lists of Pricebook2 and Product2 records, and the unit price.
   * @param doInsert Whether to insert the PricebookEntry records into the database.
   * @param uow The unit of work to use for inserting the PricebookEntry records.
   * @return An array of created PricebookEntry records.
   */
  public static PricebookEntry[] generatePricebookEntries(
    PricebookEntryWrapper pbeWrapper,
    Boolean doInsert,
    fflib_SObjectUnitOfWork uow
  ) {
    TestFactory.clearData();
    List<PricebookEntry> pricebookEntries = new List<PricebookEntry>();
    for (Pricebook2 pb : pbeWrapper.pbs) {
      for (Product2 p : pbeWrapper.products) {
        PricebookEntry pbe = new PricebookEntry(
          Pricebook2Id = pb.Id,
          Product2Id = p.Id,
          UnitPrice = pbeWrapper.unitPrice,
          IsActive = true
        );
        pricebookEntries.add(pbe);
        if (doInsert) {
          uow.registerNew(pbe);
        }
      }
    }
    if (doInsert) {
      uow.commitWork();
    }
    return pricebookEntries;
  }

  /**
   * @description A wrapper class to hold a PricebookEntry and its associated Product2.
   */
  public class PricebookEntryWrapper {
    /** @description List of PricebookEntry records */
    public List<Pricebook2> pbs { get; set; }
    /** @description List of associated Product2 records */
    public List<Product2> products { get; set; }
    /** @description The unit price for the PricebookEntry */
    Decimal unitPrice { get; set; }

    /**
     * @description Constructor to initialize the PricebookEntryWrapper with provided PricebookEntry, Product2, and unit price.
     * @param pbs The list of Pricebook2 records.
     * @param products The list of associated Product2 records.
     * @param unitPrice The unit price for the PricebookEntry.
     */
    public PricebookEntryWrapper(
      Pricebook2[] pbs,
      Product2[] products,
      Decimal unitPrice
    ) {
      this.pbs = pbs;
      this.products = products;
      this.unitPrice = unitPrice;
    }
  }
}
