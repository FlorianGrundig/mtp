var Exercise = require('./exercise.model');

'use strict';

exports.index = function(req, res) {
    Exercise.find({'email': req.user.email}, function (err, categories) {
        if(err) { return handleError(res, err); }
        return res.json(200, categories);
    });
};

// Creates a new thing in the DB.
exports.create = function(req, res) {
    var exercise = new Exercise(req.body);
    exercise.email = req.user.email;

    exercise.save( function(err) {
        if(err) { return handleError(res, err); }
        return res.json(201);
    });
};


function handleError(res, err) {
  return res.send(500, err);
}