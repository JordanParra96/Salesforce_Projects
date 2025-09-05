import { createElement } from "lwc";
import NotificationConsole from "c/notificationConsole";
import { subscribe, unsubscribe } from "lightning/empApi";

// Mocks para empApi
jest.mock("lightning/empApi", () => {
  return {
    subscribe: jest.fn((channel, replayId, callback) => {
      callback({
        data: {
          event: { replayId: 1 },
          payload: {
            Message__c: "Test message",
            CreatedDate: new Date().toISOString()
          }
        }
      });
      return Promise.resolve({ id: "123" });
    }),
    unsubscribe: jest.fn(() => Promise.resolve()),
    onError: jest.fn((cb) => {
      cb({ message: "Test error" });
    })
  };
});

describe("c-notification-console", () => {
  afterEach(() => {
    // The jsdom instance is shared across test cases in a single file so reset the DOM
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }

    // Prevent data saved on mocks from leaking between tests
    jest.clearAllMocks();
  });

  it("registers subscribe and handles notification and toast on connectedCallback", async () => {
    // Arrange
    const element = createElement("c-notification-console", {
      is: NotificationConsole
    });

    // Act
    const dispatchSpy = jest.spyOn(element, "dispatchEvent");
    document.body.appendChild(element);

    await Promise.resolve();

    // Assert
    expect(subscribe).toHaveBeenCalled();
    const toastEvent = dispatchSpy.mock.calls.find(
      (call) => call[0].detail?.variant === "success"
    );

    expect(toastEvent).toBeDefined();
  });

  it("unregisters itself as unsubscribe handler on connected callback", async () => {
    // Arrange
    const element = createElement("c-notification-console", {
      is: NotificationConsole
    });

    // Act
    document.body.appendChild(element);
    document.body.removeChild(element);

    await Promise.resolve();

    // Assert
    // Validate if pubsub got registered after connected to the DOM
    expect(unsubscribe).toHaveBeenCalled();
  });

  it("handleClearClick should remove the existing notifications", () => {
    // Arrange
    const element = createElement("c-notification-console", {
      is: NotificationConsole
    });

    document.body.appendChild(element);
    // Act
    element.notifications = [{ id: 1, message: "Test", time: "12:00" }];

    return Promise.resolve().then(() => {
      const button = element.shadowRoot.querySelector("lightning-button-icon");
      button.click();

      return Promise.resolve().then(() => {
        const items = element.shadowRoot.querySelectorAll("p");
        expect(items.length).toBe(0);
      });
    });
  });

  it("handleNotificationEvent parses and adds notification, fires toast", async () => {
    // Arrange
    const element = createElement("c-notification-console", {
      is: NotificationConsole
    });

    document.body.appendChild(element);

    const toastHandler = jest.fn();
    element.dispatchEvent = toastHandler;

    const event = new CustomEvent("message", {
      detail: {
        payload: {
          Message__c: "Test message",
          CreatedDate: "2025-07-22T12:00:00.000Z"
        }
      }
    });

    element.shadowRoot.dispatchEvent(event);
    await Promise.resolve();

    const paragraphs = element.shadowRoot.querySelectorAll("p");
    expect(paragraphs.length).toBeGreaterThan(0);
    expect(paragraphs[0].textContent).toBe("Test message");
    expect(toastHandler).toHaveBeenCalled();
  });
});
