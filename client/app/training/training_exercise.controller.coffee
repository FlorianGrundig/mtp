'use strict'

angular.module 'mtpApp'
.controller 'TrainingExerciseCtrl', ($scope, $http, User, CategoryService, ExerciseService, exerciseData) ->

  $scope.exercise = exerciseData.data

  if ($scope.exercise.history.length > 0)
    $scope.experience = $scope.exercise.history[..].pop().experience
  else
    $scope.experience = 0

  $scope.exercise_done = (exercise) ->
    exercise.history.push
      date: new Date(),
      experience: $scope.experience

    ExerciseService.upsert exercise

    cal.update(exercise.history);
    cal.options.data = exercise.history;

  startDate = new Date()
  startDate.setMonth(startDate.getMonth() - 1)

  parser = (history) ->
    stats = {};
    result = {};

    if history.length
      history.forEach (e) ->

        e_date = new Date(e.date)
        entryDate = new Date(e_date.getUTCFullYear(), e_date.getUTCMonth(),e_date.getUTCDate());

        if (stats[entryDate])
          stats[entryDate].counter++
          stats[entryDate].sum = stats[entryDate].sum +  e.experience
        else
          stats[entryDate] = {}
          stats[entryDate].counter = 1
          stats[entryDate].sum = e.experience

      for k,stat of stats
        average = Math.round(stat.sum / stat.counter)
        result[new Date(k).getTime() / 1000] = average
    result


  cal = new CalHeatMap();
  cal.init({
    domain: "month",
    subDomain: "day",
    subDomainTextFormat: "%d",
    cellSize: 15,
    start: startDate,
    range: 2,
    displayLegend: true,
    highlight: "now",
    legendVerticalPosition: "center",
    legendHorizontalPosition: "right",
    legendOrientation: "vertical",
    legend: [1,2,3,4],
    afterLoadData: parser
  });
  cal.update($scope.exercise.history);
  cal.options.data = $scope.exercise.history;



