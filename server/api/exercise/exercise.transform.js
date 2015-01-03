'use strict';

function getProgress(exercise) {
  var sum = 0;
  var counter = 0;
  exercise.history.slice(-5).forEach(function(e){
    sum += e.experience;
    counter++
  });

  if (counter === 0){
    counter++
  }
  var ratio = Math.round(sum / counter);
  return ratio.toFixed(1);
}

exports.transformForOverview = function (exercises) {
    var result = [];

    exercises.forEach(function(e){
      result.push({
        _id: e.id,
        name: e.name,
        level: e.level,
        replay: e.replay,
        duration: e.duration,
        times: e.history.length,
        progress: getProgress(e)
      })
    });

    return result;
};

