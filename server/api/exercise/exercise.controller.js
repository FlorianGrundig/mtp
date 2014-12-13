var transformatorForClient = require('./exercise.transform');
var Exercise = require('./exercise.model');

'use strict';

exports.index = function (req, res) {
  Exercise.find({'email': req.user.email}, function (err, exercises) {
    if (err) {
      return handleError(res, err);
    }

    return res.json(200, transformatorForClient.transformForOverview(exercises));
  });
};

exports.upsert = function (req, res) {
  var exercise = new Exercise(req.body);

  if (req.body._id){

    Exercise.findById(req.body._id, function (err, exercise_db) {
      if (err) return handleError(req,err);

      exercise_db.categories = exercise.categories;
      exercise_db.duration = exercise.duration;
      exercise_db.hints = exercise.hints;
      exercise_db.level = exercise.level;
      exercise_db.max_experience = exercise.max_experience;
      exercise_db.name = exercise.name;
      exercise_db.replay = exercise.replay;
      exercise_db.source = exercise.source;
      exercise_db.history = exercise.history;


      exercise_db.save(function (err) {
        if (err) return handleError(res, err);
        res.json(201);
      });
    });

  } else {
    exercise.email = req.user.email;
    exercise.save(function (err) {
      if (err) {
        return handleError(res, err);
      }
      return res.json(201);
    });
  }
};


/**
 * Get a single exercise
 */
exports.show = function (req, res, next) {
  var userId = req.params.id;

  if (!userId){
    res.send(400);
    return;
  }

  Exercise.findById(userId, function (err, exercise_db) {
    if (err) return handleError(req,err);
    if (!exercise_db) return res.send(401);
    res.json(exercise_db);
  });

};

function handleError(res, err) {
  return res.send(500, err);
}
