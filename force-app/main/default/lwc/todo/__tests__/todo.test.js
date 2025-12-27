import { createElement } from "@lwc/engine-dom";
import Todo from "c/todo";

import getTodoItems from "@salesforce/apex/TodoCtrl.getTodoItems";
import { refreshApex } from "@salesforce/apex";
import {
  registerApexTestWireAdapter,
  registerTestWireAdapter
} from "@salesforce/sfdx-lwc-jest";
import {
  EnclosingUtilityId,
  enablePopout,
  updateUtility
} from "lightning/platformUtilityBarApi";
import { CurrentPageReference } from "lightning/navigation";

const getTodoItemsAdapter = registerApexTestWireAdapter(getTodoItems);
const EnclosingUtilityIdAdapter = registerTestWireAdapter(EnclosingUtilityId);
const CurrentPageReferenceAdapter =
  registerTestWireAdapter(CurrentPageReference);

const flushPromises = () => Promise.resolve();

describe("c-todo", () => {
  afterEach(() => {
    // The jsdom instance is shared across test cases in a single file so reset the DOM
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
    jest.clearAllMocks();
  });

  it("calls enablePopout when EnclosingUtilityId is provided", async () => {
    const element = createElement("c-todo", { is: Todo });
    document.body.appendChild(element);

    // Emit a utility id and verify enablePopout was called
    EnclosingUtilityIdAdapter.emit("utility-123");
    await flushPromises();

    expect(enablePopout).toHaveBeenCalledWith("utility-123", false, {
      disabledText: "disabled"
    });
  });

  it("uses recordId from CurrentPageReference to fetch and render items", async () => {
    const element = createElement("c-todo", { is: Todo });
    document.body.appendChild(element);

    const items = [
      { Id: "r1", Due_Date__c: new Date().toISOString(), Name: "R1" }
    ];

    CurrentPageReferenceAdapter.emit({ attributes: { recordId: "001ABC" } });
    // Emit the wire data that would be fetched using the recordId
    getTodoItemsAdapter.emit(items);
    await flushPromises();

    const articles = element.shadowRoot.querySelectorAll("article.slds-card");
    expect(articles.length).toBe(1);
  });

  it("marks overdue items and updates utility with overdue count", async () => {
    const element = createElement("c-todo", { is: Todo });
    document.body.appendChild(element);

    // Provide a utility id first so updateUtility will be called with it
    EnclosingUtilityIdAdapter.emit("utility-789");

    const pastDate = new Date(
      Date.now() - 2 * 24 * 60 * 60 * 1000
    ).toISOString();
    const futureDate = new Date(
      Date.now() + 2 * 24 * 60 * 60 * 1000
    ).toISOString();

    const items = [
      { Id: "a1", Due_Date__c: pastDate, Name: "Past" },
      { Id: "a2", Due_Date__c: futureDate, Name: "Future" }
    ];

    getTodoItemsAdapter.emit(items);
    await flushPromises();

    // Verify DOM rendering of items
    const articles = element.shadowRoot.querySelectorAll("article.slds-card");
    expect(articles.length).toBe(2);

    // One overdue badge should appear
    const overdueBadges =
      element.shadowRoot.querySelectorAll(".slds-theme_error");
    expect(overdueBadges.length).toBe(1);

    // Verify updateUtility was invoked with expected args
    expect(updateUtility).toHaveBeenCalled();
    const lastCall =
      updateUtility.mock.calls[updateUtility.mock.calls.length - 1];
    expect(lastCall[0]).toBe("utility-789");
    expect(lastCall[1].label).toContain("Overdue");
    expect(lastCall[1].highlighted).toBe(true);
  });

  it("resets utility label when there are no overdue items", async () => {
    const element = createElement("c-todo", { is: Todo });
    document.body.appendChild(element);

    EnclosingUtilityIdAdapter.emit("utility-555");

    const futureDate1 = new Date(
      Date.now() + 2 * 24 * 60 * 60 * 1000
    ).toISOString();
    const futureDate2 = new Date(
      Date.now() + 3 * 24 * 60 * 60 * 1000
    ).toISOString();

    const items = [
      { Id: "b1", Due_Date__c: futureDate1, Name: "F1" },
      { Id: "b2", Due_Date__c: futureDate2, Name: "F2" }
    ];

    getTodoItemsAdapter.emit(items);
    await flushPromises();

    // Verify DOM rendering of items
    const articles = element.shadowRoot.querySelectorAll("article.slds-card");
    expect(articles.length).toBe(2);

    // No overdue badge should appear
    const overdueBadges =
      element.shadowRoot.querySelectorAll(".slds-theme_error");
    expect(overdueBadges.length).toBe(0);

    expect(updateUtility).toHaveBeenCalled();
    const lastCall =
      updateUtility.mock.calls[updateUtility.mock.calls.length - 1];
    expect(lastCall[0]).toBe("utility-555");
    expect(lastCall[1].label).toBe("To-do List");
    expect(lastCall[1].highlighted).toBe(false);
  });

  it("calls refreshApex on success (via form success event)", async () => {
    const element = createElement("c-todo", { is: Todo });
    document.body.appendChild(element);

    // Emit an initial wire response so the component has a wireResult reference
    const items = [];
    getTodoItemsAdapter.emit(items);
    await flushPromises();

    const form = element.shadowRoot.querySelector("lightning-record-edit-form");
    form.dispatchEvent(new CustomEvent("success"));

    // refreshApex is mocked so verify it was invoked
    expect(refreshApex).toHaveBeenCalled();
  });
});
