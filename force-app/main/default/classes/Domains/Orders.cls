/**
 * @description Domain class for Order objects.
 */
public with sharing class Orders extends fflib_SObjectDomain {
  /**
   * @description Constructor for Orders domain class.
   * @param sOjectList List of Order SObjects.
   */
  public Orders(list<Order> sOjectList) {
    super(sOjectList);
  }

  /**
   * @description Factory method to create an instance of Orders.
   * @param sObjectList List of Order SObjects.
   * @return An instance of Orders domain class.
   */
  public class Constructor implements fflib_SObjectDomain.IConstructable {
    /**
     * @description Constructs an instance of Orders domain class.
     * @param sObjectList List of Order SObjects.
     * @return An instance of Orders domain class.
     */
    public fflib_SObjectDomain construct(List<SObject> sObjectList) {
      return new Orders(sObjectList);
    }
  }

  /**
   * @description Factory method to add a bonus bouquet when an order is activated.
   * @param existingRecords Map of existing records before update.
   */
  public override void onBeforeUpdate(Map<Id, SObject> existingRecords) {
    OrderItemUtility.addBonusBouquet(
      getChangedRecords(new Set<String>{ 'Status' })
    );
  }
}
