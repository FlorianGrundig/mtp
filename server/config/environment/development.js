'use strict';

// Development specific configuration
// ==================================
module.exports = {
  // MongoDB connection options
  mongo: {
    uri: 'mongodb://'+(process.env.DOCKER_IP || 'localhost')+':27017/mtp-dev'
  },
  ip: "0.0.0.0",

  seedDB: true
};
