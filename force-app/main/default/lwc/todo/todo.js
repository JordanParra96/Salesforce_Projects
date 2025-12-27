import { LightningElement, wire } from "lwc";

import TODO_OBJECT from "@salesforce/schema/Todo_Item__c";
import NAME_FIELD from "@salesforce/schema/Todo_Item__c.Name";
import DUE_DATE_FIELD from "@salesforce/schema/Todo_Item__c.Due_Date__c";
import RELATED_RECORD_ID from "@salesforce/schema/Todo_Item__c.RelatedRecordId__c";

import { refreshApex } from "@salesforce/apex";
import getTodoItems from "@salesforce/apex/TodoCtrl.getTodoItems";

export default class Todo extends LightningElement {
  objectApiName = TODO_OBJECT;
  nameField = NAME_FIELD;
  dueDateField = DUE_DATE_FIELD;
  relatedRecordId = RELATED_RECORD_ID;

  wireResult;
  todoItems;

  recordId = null;

  @wire(getTodoItems, { relatedRecordId: "$recordId" })
  handleList(wireResult) {
    this.wireResult = wireResult;
    if (wireResult.data) {
      this.todoItems = wireResult.data.map((item) => {
        let isOverDue = new Date(item.Due_Date__c) < new Date();
        return { ...item, isOverDue: isOverDue };
      });
    }
  }

  handleSuccess() {
    refreshApex(this.wireResult);
  }
}
