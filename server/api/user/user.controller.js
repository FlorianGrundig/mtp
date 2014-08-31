'use strict';

var passport = require('passport');
var config = require('../../config/environment');
var jwt = require('jsonwebtoken');
var User = require('./user.model');

var validationError = function(res, err) {
  return res.json(422, err);
};

/**
 * Get list of users
 * restriction: 'admin'
 */
exports.index = function(req, res) {
// TODO real implementation
//    User.find({}, '-salt -hashedPassword', function (err, users) {
//        if(err) return res.send(500, err);
//        res.json(200, users);
//    });
    res.json(200, [{
        _id: 'fooid',
        name: 'foo' ,
        email: 'foo@bar.se',
        role: 'admin',
        hashedPassword: '234324',
        provider: 'local'

    }]);
};

/**
 * Creates a new user
 */
exports.create = function (req, res, next) {
    console.log('create new user with '+ req.body);
    var newUser = User.create(req.body);

    newUser.save(function(err, user) {
        if (err) return validationError(res, err);
        var token = jwt.sign({_id: user.login }, config.secrets.session, { expiresInMinutes: 60*5 });
        res.json({ token: token });
    });
};

/**
 * Get a single user
 */
exports.show = function (req, res, next) {
// TODO real implementation
  var userId = req.params.id;

//    User.findById(userId, function (err, user) {
//        if (err) return next(err);
//        if (!user) return res.send(401);
//        res.json(user.profile);
//    });
    res.json({
        '_id': 'fooid',
        'name': 'foo',
        'role': 'admin'
    });
};

/**
 * Deletes a user
 * restriction: 'admin'
 */
exports.destroy = function(req, res) {
// TODO real implementation
//    User.findByIdAndRemove(req.params.id, function(err, user) {
//        if(err) return res.send(500, err);
//        return res.send(204);
//    });
    return res.send(204);
};

/**
 * Change a users password
 */
exports.changePassword = function(req, res, next) {
  var userId = req.user.login;
  var oldPass = String(req.body.oldPassword);
  var newPass = String(req.body.newPassword);
    User.findById(userId, function (err, user) {
        if(user.authenticate(oldPass)) {
            user.hashedPassword = user.encryptPassword(newPass);
            user.save(function(err) {
                if (err) return validationError(res, err);
                res.send(200);
            });
        } else {
            res.send(403);
        }
    });
};

/**
 * Get my info
 */
exports.me = function(req, res, next) {
  var userId = req.user.login;
    User.findOne({
        login: userId
    }, function(err, user) { // don't ever give out the password or salt
        if (err) return next(err);
        if (!user) return res.json(401);
        user.hashedPassword = undefined;
        user.salt = undefined;
        res.json(user);
    });
};

/**
 * Authentication callback
 */
exports.authCallback = function(req, res, next) {
  res.redirect('/');
};
