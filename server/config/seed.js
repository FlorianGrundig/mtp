/**
 * Populate DB with sample data on server start
 * to disable, edit config/environment/index.js, and set `seedDB: false`
 */

'use strict';

var User = require('../api/user/user.model');

User.find({email: 'test@test.com'}).remove(function(){
    User.create({
        provider: 'local',
        name: 'Test User',
        email: 'test@test.com',
        password: 'test'
    });
}).exec(function(s){
    console.log('s ', s)
});

User.find({'email': 'admin@admin.com'}).remove(function(){
    User.create({
        provider: 'local',
        role: 'admin',
        name: 'Admin',
        email: 'admin@admin.com',
        password: 'admin'
    });
});


