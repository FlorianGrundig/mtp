'use strict';

// TODO use this var
var server = process.env.MONGO_SERVER || 'localhost';

// Test specific configuration
// ===========================
module.exports = {
  // MongoDB connection options

  mongo: {
    uri: 'mongodb://localhost:27097/mtp-test'
  },

  seedDB: true
};