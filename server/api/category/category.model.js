'use strict';
var http = require('http');
var crypto = require('crypto');
var config = require('../../config/environment');



function Category(props) {
    this.login = props.login || '';
    this.name = props.name || '';

    if (props._id){
        this._id = props._id.$oid;
    }

}

Category.prototype.validate = function () {
    console.log('unimplemented method validate was called...');
};

Category.prototype.save = function (callback) {
    var userString = JSON.stringify(this);
    var headers = {
        'Content-Type': 'application/json',
        'Content-Length': userString.length
    };
    var options = {
        host: config.backendHost,
        port: config.backendPort,
        path: '/category/save',
        method: 'POST',
        headers: headers
    };


    // Setup the request.  The options parameter is
// the object we defined above.
    var req = http.request(options, function (response) {
        response.setEncoding('utf-8');

        var responseString = '';
        response.on('data', function (data) {
            responseString += data;
        });

        response.on('end', function () {
            var resultObject;
            try {
                resultObject = JSON.parse(responseString);
                callback(null, new Category(resultObject));
            } catch (e) {
                callback(e, null);
            }
        });
    });
    req.on('error', function (e) {
        callback(e, null);
    });
    req.write(userString);
    req.end();
};

function create(props) {
    return new Category(props);
}

function find(login, callback){
    var requestBody = JSON.stringify({login: login});

    var headers = {
        'Content-Type': 'application/json',
        'Content-Length': requestBody.length
    };
    var options = {
        host: config.backendHost,
        port: config.backendPort,
        path: '/category/find',
        method: 'POST',
        headers: headers
    };
    var req = http.request(options, function (res) {
        res.setEncoding('utf-8');

        var responseString = '';

        res.on('data', function (data) {
            responseString += data;
        });

        res.on('end', function () {
           var categories = [];
            try {
                var resultObject = JSON.parse(responseString);
                for (var i = 0; i < resultObject.length; i++){
                    categories.push(new Category(resultObject[i]))
                }

                callback(null, categories);
            } catch (e) {
                callback(e, null);
            }
        });
    });

    req.on('error', function (e) {
        callback(e, null);
    });


    req.write(requestBody);
    req.end();
}


function findById(id,callback){
    return findOne({login: id},callback)
}

function findOne(user, callback) {
    var userString = JSON.stringify(user);
    var headers = {
        'Content-Type': 'application/json',
        'Content-Length': userString.length
    };
    var options = {
        host: config.backendHost,
        port: config.backendPort,
        path: '/user/findOne',
        method: 'POST',
        headers: headers
    };
    var req = http.request(options, function (res) {
        res.setEncoding('utf-8');

        var responseString = '';

        res.on('data', function (data) {
            responseString += data;
        });

        res.on('end', function () {
            try {
                var resultObject = JSON.parse(responseString);
                callback(null, new User(resultObject));
            } catch (e) {
                callback(e, null);
            }
        });
    });

    req.on('error', function (e) {
        callback(e, null);
    });

    req.write(userString);
    req.end();

}

module.exports = {
    find: find,
    findById: findById,
    findOne: findOne,
    create: create
};
