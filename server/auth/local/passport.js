var passport = require('passport');
var LocalStrategy = require('passport-local').Strategy;
var User = require('../../api/user/user.model');

exports.setup = function ( config) {
  passport.use(new LocalStrategy({
      usernameField: 'login',
      passwordField: 'password' // this is the virtual field on the model
    },
    function(login, password, done) {
        console.log('local passport.js was called with password: ' + password);
        User.findOne({
           login: login
        }, function(err, user) {
            if (err) return done(err);

            if (!user) {
                return done(null, false, { message: 'This email is not registered.' });
            }
            if (!user.authenticate(password)) {
                return done(null, false, { message: 'This password is not correct.' });
            }
            return done(null, user);
        });
    }
  ));
};