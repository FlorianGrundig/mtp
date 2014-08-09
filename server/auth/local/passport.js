var passport = require('passport');
var LocalStrategy = require('passport-local').Strategy;

exports.setup = function ( config) {
  passport.use(new LocalStrategy({
      usernameField: 'email',
      passwordField: 'password' // this is the virtual field on the model
    },
    function(email, password, done) {
        // todo implement against real backend
//        User.findOne({
//            email: email.toLowerCase()
//        }, function(err, user) {
//            if (err) return done(err);
//
//            if (!user) {
//                return done(null, false, { message: 'This email is not registered.' });
//            }
//            if (!user.authenticate(password)) {
//                return done(null, false, { message: 'This password is not correct.' });
//            }
//            return done(null, user);
//        });
        var user = {
            _id: 'foo',
            name: 'foo' ,
            email: 'foo@bar.se',
            role: 'admin',
            hashedPassword: '234324',
            provider: 'local'

            };

//        if (!user) {
//          return done(null, false, { message: 'This email is not registered.' });
//        }
        return done(null, user);
    }
  ));
};