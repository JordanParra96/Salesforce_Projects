/**
 * @description Test class for PricebookEntrySelector.
 */
@isTest
private class PricebookEntrySelectorTest {
  @TestSetup
  static void makeData() {
    Pricebook2[] pbs = TestFactory.generatePricebooks(3, true);

    Product2[] products = TestFactory.generateSpecificProducts(
      new List<String>{ 'PROD-001', 'PROD-002', 'PROD-003' },
      true
    );

    String prID2 = Test.getStandardPricebookId();

    Map<String, Object> pbParams = new Map<String, Object>{
      'pbId' => prID2,
      'product' => products[0],
      'unitPrice' => 100.00,
      'isActive' => true,
      'doInsert' => true
    };

    PricebookEntry standardPbe = TestFactory.getPricebookEntry(pbParams);

    TestPricebookFactory.PricebookEntryWrapper pbeWrapper = new TestPricebookFactory.PricebookEntryWrapper(
      pbs,
      new List<Product2>{ products[0] },
      150.00
    );
    TestFactory.generatePricebookEntries(pbeWrapper, true);
  }

  /**
   * @description Test method for PricebookEntrySelector class.
   */
  @isTest
  static void selectById() {
    List<PricebookEntry> pbeList = new PricebookEntrySelector().selectAll(3);
    List<PricebookEntry> pbes = new PricebookEntrySelector()
      .selectById(new Set<Id>{ pbeList[0].Id, pbeList[1].Id, pbeList[2].Id });

    System.assertEquals(
      3,
      pbes.size(),
      'Should select 3 PricebookEntry records by ID'
    );
  }

  /**
   * @description Test method for selecting PricebookEntry records by Product2Id.
   */
  @isTest
  static void selectByProductId() {
    Set<Id> productIdSet = new Set<Id>();
    List<PricebookEntry> pbeList = new PricebookEntrySelector().selectAll(3);
    for (PricebookEntry pbe : pbeList) {
      productIdSet.add(pbe.Product2Id);
    }
    List<PricebookEntry> pbes = new PricebookEntrySelector()
      .selectByProductId(productIdSet, 10);
    System.assertEquals(
      4,
      pbes.size(),
      'Should select 4 PricebookEntry records by Product2Id'
    );
  }

  /**
   * @description Test method for selecting all PricebookEntry records.
   */
  @isTest
  static void selectAll() {
    List<PricebookEntry> pbes = new PricebookEntrySelector().selectAll();
    System.assert(
      pbes.size() >= 3,
      'Should select at least 3 PricebookEntry records in total'
    );
  }

  /**
   * @description Test method for selecting all PricebookEntry records with a limit.
   */
  @isTest
  static void selectAllWithLimit() {
    List<PricebookEntry> pbes = new PricebookEntrySelector().selectAll(2);
    System.assertEquals(
      2,
      pbes.size(),
      'Should select exactly 2 PricebookEntry records when limit is set to 2'
    );
  }
}
