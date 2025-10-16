import { createElement } from "lwc";
import HelloWorld from "c/helloWorld";

function getRootDiv(element) {
  return element.shadowRoot.querySelector("div");
}

describe("c-hello-world", () => {
  afterEach(() => {
    // Clean DOM
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
    jest.clearAllMocks();
  });

  it("renders greeting text", () => {
    const element = createElement("c-hello-world", { is: HelloWorld });
    document.body.appendChild(element);

    const div = getRootDiv(element);
    expect(div).not.toBeNull();
    expect(div.textContent).toBe("Hello, World!");
  });

  it("applies shade theme when objectApiName is Account", async () => {
    const element = createElement("c-hello-world", { is: HelloWorld });
    element.objectApiName = "Account";
    document.body.appendChild(element);

    // Wait a microtask for re-render cycle
    await Promise.resolve();

    const div = getRootDiv(element);
    expect(div.className).toContain("slds-box");
    expect(div.className).toContain("slds-theme_alert-texture");
    expect(div.className).toContain("slds-theme_shade");
    expect(div.className).not.toContain("slds-theme_success");
  });

  it("applies success theme when objectApiName is not Account", async () => {
    const element = createElement("c-hello-world", { is: HelloWorld });
    element.objectApiName = "Contact";
    document.body.appendChild(element);

    await Promise.resolve();

    const div = getRootDiv(element);
    expect(div.className).toContain("slds-box");
    expect(div.className).toContain("slds-theme_alert-texture");
    expect(div.className).toContain("slds-theme_success");
    expect(div.className).not.toContain("slds-theme_shade");
  });
});
