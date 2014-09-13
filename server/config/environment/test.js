'use strict';

var server = process.env.MONGO_SERVER || 'localhost';

// Test specific configuration
// ===========================
module.exports = {
  // MongoDB connection options

  mongo: {
    uri: 'mongodb://'+server+'/mtp-test'
  }
};