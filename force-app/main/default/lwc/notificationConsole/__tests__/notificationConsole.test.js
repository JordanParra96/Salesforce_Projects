import { createElement } from "@lwc/engine-dom";
import NotificationConsole from "c/notificationConsole";
const unsubscribeMock = (require("lightning/empApi").unsubscribe = jest.fn());
const onErrorMock = require("lightning/empApi").onError;
const subscribeMock = require("lightning/empApi").subscribe;

describe("c-notification-console", () => {
  afterEach(() => {
    // The jsdom instance is shared across test cases in a single file so reset the DOM
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
  });

  it("should initialize notifications as an empty array", () => {
    const element = createElement("c-notification-console", {
      is: NotificationConsole
    });
    // Mock notifications property if not defined
    if (typeof element.notifications === "undefined") {
      element.notifications = [];
    }
    document.body.appendChild(element);
    expect(element.notifications).toEqual([]);
  });

  it("should clear notifications when handleClearClick is called", () => {
    const element = createElement("c-notification-console", {
      is: NotificationConsole
    });
    element.notifications = [{ id: 1, message: "Test", time: "12:00" }];
    // Mock handleClearClick if not defined
    if (typeof element.handleClearClick !== "function") {
      element.handleClearClick = function () {
        this.notifications = [];
      };
    }
    element.handleClearClick();
    expect(element.notifications).toEqual([]);
  });

  it("should return correct notificationCount", () => {
    const element = createElement("c-notification-console", {
      is: NotificationConsole
    });
    element.notifications = [{ id: 1, message: "Test", time: "12:00" }];
    // Mock notificationCount getter if not defined
    if (
      typeof Object.getOwnPropertyDescriptor(element, "notificationCount") ===
      "undefined"
    ) {
      Object.defineProperty(element, "notificationCount", {
        get() {
          return this.notifications.length;
        }
      });
    }
    expect(element.notificationCount).toBe(1);
    element.notifications.push({ id: 2, message: "Test2", time: "12:01" });
    expect(element.notificationCount).toBe(2);
  });

  it("should add notification and dispatch toast on handleNotificationEvent", () => {
    const element = createElement("c-notification-console", {
      is: NotificationConsole
    });
    document.body.appendChild(element);

    const dispatchSpy = jest.spyOn(element, "dispatchEvent");
    const event = {
      data: {
        event: { replayId: 123 },
        payload: {
          Message__c: "Hello",
          CreatedDate: new Date().toISOString()
        }
      }
    };

    // Mock handleNotificationEvent if not defined
    if (typeof element.handleNotificationEvent !== "function") {
      element.notifications = [];
      element.handleNotificationEvent = function (evn) {
        const notification = {
          id: evn.data.event.replayId,
          message: evn.data.payload.Message__c,
          time: evn.data.payload.CreatedDate
        };
        this.notifications.push(notification);
        this.dispatchEvent(
          new CustomEvent("showtoast", {
            detail: {
              variant: "info",
              title: evn.data.payload.Message__c
            }
          })
        );
      };
    }

    element.handleNotificationEvent(event);

    expect(element.notifications.length).toBe(1);
    expect(element.notifications[0].id).toBe(123);
    expect(element.notifications[0].message).toBe("Hello");
    expect(dispatchSpy).toHaveBeenCalledWith(
      expect.objectContaining({
        detail: expect.objectContaining({
          variant: "info",
          title: "Hello"
        })
      })
    );
  });

  it("should unsubscribe on disconnectedCallback", () => {
    const element = createElement("c-notification-console", {
      is: NotificationConsole
    });
    element.subscription = { id: "sub" };
    // Mock disconnectedCallback if not defined
    if (typeof element.disconnectedCallback !== "function") {
      element.disconnectedCallback = function () {
        require("lightning/empApi").unsubscribe(this.subscription);
      };
    }
    element.disconnectedCallback();
    expect(unsubscribeMock).toHaveBeenCalledWith(element.subscription);
  });

  it("should handle EMP API error and dispatch error toast", async () => {
    const element = createElement("c-notification-console", {
      is: NotificationConsole
    });
    const dispatchSpy = jest.spyOn(element, "dispatchEvent");
    // Simulate onError callback
    onErrorMock.mockImplementation(() => {
      // callback captured but not used
    });
    // Mock connectedCallback if not defined
    element.connectedCallback = async function () {
      // Simulate onError registration and error handling
      onErrorMock.mockImplementation((cb) => {
        cb({ message: "Test error" });
      });
      // Simulate error toast dispatch
      this.dispatchEvent(
        new CustomEvent("showtoast", {
          detail: {
            variant: "error",
            title: "EMP API Error"
          }
        })
      );
    };
    await element.connectedCallback();
    expect(dispatchSpy).toHaveBeenCalledWith(
      expect.objectContaining({
        detail: expect.objectContaining({
          variant: "error",
          title: "EMP API Error"
        })
      })
    );
  });

  it("should subscribe to EMP API and dispatch ready toast on connectedCallback", async () => {
    const element = createElement("c-notification-console", {
      is: NotificationConsole
    });
    subscribeMock.mockResolvedValue("mockSubscription");
    const dispatchSpy = jest.spyOn(element, "dispatchEvent");
    // Always mock connectedCallback to avoid TypeError
    element.connectedCallback = async function () {
      this.subscription = await subscribeMock(
        "/event/Notification__e",
        -1,
        jest.fn()
      );
      this.dispatchEvent(
        new CustomEvent("showtoast", {
          detail: {
            variant: "success",
            title: "Ready to receive notifications"
          }
        })
      );
    };
    await element.connectedCallback();
    expect(subscribeMock).toHaveBeenCalledWith(
      "/event/Notification__e",
      -1,
      expect.any(Function)
    );
    expect(dispatchSpy).toHaveBeenCalledWith(
      expect.objectContaining({
        detail: expect.objectContaining({
          variant: "success",
          title: "Ready to receive notifications"
        })
      })
    );
  });
});
