/**
 * @description
 * This class is responsible for handling changes on the OpportunityChangeEvent object.
 */
public with sharing class OpportunityChanges {
  public List<SObject> records;
  /**
   * @description Constructor for OpportunityChanges domain class.
   * @param sOjectList List of Opportunity Change Event SObjects.
   */
  public OpportunityChanges(List<SObject> sOjectList) {
    this.records = sOjectList;
  }

  /**
   * @description After insert trigger handler to process Opportunity Change Events.
   */
  public void handleAfterInsert() {
    List<Task> tasks = new List<Task>();

    for (
      OpportunityChangeEvent event : (List<OpportunityChangeEvent>) this.records
    ) {
      EventBus.ChangeEventHeader header = event.ChangeEventHeader;
      if ((header.changetype == 'UPDATE') && (event.isWon == true)) {
        Task tk = new Task();
        tk.Subject = 'Follow up on won opportunities: ' + header.recordIds;
        tk.OwnerId = header.CommitUser;
        tasks.add(tk);
      }
    }

    if (tasks.size() > 0) {
      insert as user tasks;
    }
  }
}
