// Manual Jest mock for lightning/platformUtilityBarApi
// Exports a simple wire-adapter placeholder and spies for API functions
module.exports = {
  EnclosingUtilityId: {},
  enablePopout: jest.fn(),
  updateUtility: jest.fn()
};
