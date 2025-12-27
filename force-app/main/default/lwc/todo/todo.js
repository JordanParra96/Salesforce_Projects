import { LightningElement, wire } from "lwc";

import TODO_OBJECT from "@salesforce/schema/Todo_Item__c";
import NAME_FIELD from "@salesforce/schema/Todo_Item__c.Name";
import DUE_DATE_FIELD from "@salesforce/schema/Todo_Item__c.Due_Date__c";
import RELATED_RECORD_ID from "@salesforce/schema/Todo_Item__c.RelatedRecordId__c";

import { refreshApex } from "@salesforce/apex";
import getTodoItems from "@salesforce/apex/TodoCtrl.getTodoItems";

import {
  enablePopout,
  EnclosingUtilityId,
  updateUtility
} from "lightning/platformUtilityBarApi";
import { CurrentPageReference } from "lightning/navigation";

export default class Todo extends LightningElement {
  objectApiName = TODO_OBJECT;
  nameField = NAME_FIELD;
  dueDateField = DUE_DATE_FIELD;
  relatedRecordId = RELATED_RECORD_ID;

  wireResult;
  todoItems;

  recordId = null;

  utilityAttrs = {
    label: "To-do List",
    highlighted: false
  };

  @wire(EnclosingUtilityId)
  wiredResultUtility(utilityId) {
    if (utilityId) {
      this.utilityId = utilityId;
      enablePopout(this.utilityId, false, {
        disabledText: "disabled"
      });
    }
  }

  @wire(CurrentPageReference)
  wireCurrentPageReference(currentPageReference) {
    if (currentPageReference) {
      this.recordId = currentPageReference.attributes.recordId
        ? currentPageReference.attributes.recordId
        : null;
    }
  }

  @wire(getTodoItems, { relatedRecordId: "$recordId" })
  handleList(wireResult) {
    this.wireResult = wireResult;
    if (wireResult.data) {
      let overdueTaskCount = 0;
      this.todoItems = wireResult.data.map((item) => {
        let isOverDue = new Date(item.Due_Date__c) < new Date();
        if (isOverDue) {
          overdueTaskCount++;
        }
        return { ...item, isOverDue: isOverDue };
      });
      if (overdueTaskCount > 0) {
        this.utilityAttrs.label += " (" + overdueTaskCount + " Overdue)";
        this.utilityAttrs.highlighted = true;
        updateUtility(this.utilityId, this.utilityAttrs);
      } else {
        this.utilityAttrs.label = "To-do List";
        this.utilityAttrs.highlighted = false;
        updateUtility(this.utilityId, this.utilityAttrs);
      }
    }
  }

  handleSuccess() {
    refreshApex(this.wireResult);
  }
}
