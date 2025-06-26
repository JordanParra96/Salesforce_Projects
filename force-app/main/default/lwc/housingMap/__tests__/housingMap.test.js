import { createElement } from 'lwc';
import HousingMap from 'c/housingMap';
import getHouses from '@salesforce/apex/HouseService.getRecords';

jest.mock(
    '@salesforce/apex/HouseService.getRecords',
    () => {
        return {
            default: jest.fn()
        };
    },
    { virtual: true }
);

const mockData = [
    {
        Name: 'Casa 1',
        Address__c: 'Calle 123',
        City__c: 'Bogotá',
        State__c: 'Cundinamarca'
    },
    {
        Name: 'Casa 2',
        Address__c: 'Carrera 45',
        City__c: 'Medellín',
        State__c: 'Antioquia'
    }
];

describe('c-housing-map', () => {
    afterEach(() => {
        // Limpiar el DOM después de cada prueba
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        jest.clearAllMocks();
    });

    it('muestra los marcadores en el mapa cuando los datos se recuperan correctamente', async () => {
        getHouses.mockResolvedValue(mockData);

        const element = createElement('c-housing-map', {
            is: HousingMap
        });
        document.body.appendChild(element);

        // Espera a que el wire service se resuelva
        await Promise.resolve();

        const lightningMap = element.shadowRoot.querySelector('lightning-map');
        expect(lightningMap).not.toBeNull();
        expect(lightningMap.mapMarkers.length).toBe(2);

        expect(lightningMap.mapMarkers).toEqual([
            {
                location: {
                    Street: 'Calle 123',
                    City: 'Bogotá',
                    State: 'Cundinamarca'
                },
                title: 'Casa 1'
            },
            {
                location: {
                    Street: 'Carrera 45',
                    City: 'Medellín',
                    State: 'Antioquia'
                },
                title: 'Casa 2'
            }
        ]);
    });

    it('muestra el error si la llamada al método Apex falla', async () => {
        getHouses.mockRejectedValue(new Error('Error de servidor'));

        const element = createElement('c-housing-map', {
            is: HousingMap
        });
        document.body.appendChild(element);

        await Promise.resolve();

        // Puedes validar que el mapa no se renderizó por ejemplo
        const lightningMap = element.shadowRoot.querySelector('lightning-map');
        expect(lightningMap).toBeNull();
    });
});