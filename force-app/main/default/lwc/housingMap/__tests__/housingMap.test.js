import { createElement } from "@lwc/engine-dom";
import HousingMap from "c/housingMap";
import getHouses from "@salesforce/apex/HouseService.getRecords";
import { registerApexTestWireAdapter } from "@salesforce/sfdx-lwc-jest";

// Importa el adaptador de prueba
const getHousesAdapter = registerApexTestWireAdapter(getHouses);

// Helper
const flushPromises = () => Promise.resolve().then(() => {});

const mockData = [
  {
    Name: "Casa 1",
    Address__c: "Calle 123",
    City__c: "Bogotá",
    State__c: "Cundinamarca"
  },
  {
    Name: "Casa 2",
    Address__c: "Carrera 45",
    City__c: "Medellín",
    State__c: "Antioquia"
  }
];

describe("c-housing-map", () => {
  afterEach(() => {
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
    jest.clearAllMocks();
  });

  it("muestra los marcadores correctamente", async () => {
    const element = createElement("c-housing-map", {
      is: HousingMap
    });
    document.body.appendChild(element);

    // Simular que el wire recibe datos
    getHousesAdapter.emit(mockData);

    await flushPromises();

    const lightningMap = element.shadowRoot.querySelector("lightning-map");
    expect(lightningMap).not.toBeNull();

    expect(lightningMap.mapMarkers).toEqual([
      {
        location: {
          Street: "Calle 123",
          City: "Bogotá",
          State: "Cundinamarca"
        },
        title: "Casa 1"
      },
      {
        location: {
          Street: "Carrera 45",
          City: "Medellín",
          State: "Antioquia"
        },
        title: "Casa 2"
      }
    ]);
  });

  it("muestra el componente aún si hay error", async () => {
    const element = createElement("c-housing-map", {
      is: HousingMap
    });
    document.body.appendChild(element);

    getHousesAdapter.error(); // Simula error del wire
    await flushPromises();

    const lightningMap = element.shadowRoot.querySelector("lightning-map");
    expect(lightningMap).not.toBeNull(); // el componente sigue renderizado
    expect(lightningMap.mapMarkers).toBeUndefined();
  });
});
