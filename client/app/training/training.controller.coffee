'use strict'

angular.module 'mtpApp'
.controller 'TrainingCtrl', ($scope, $http, User, CategoryService, ExerciseService) ->
  $scope.currentUser = User.get()
  $scope.categories = CategoryService.list()
  $scope.exercises = ExerciseService.list()

  $scope.low = 0
  $scope.high = 100

  $scope.getProgress = (exercise) ->
    sum = 0
    counter = 0
    exercise.history.slice(-5).forEach (e) ->
      sum += e.experience
      counter++

    if counter is 0
      counter++
    ratio = Math.round(sum / counter)
    ratio.toFixed(1)


  $scope.exercise = undefined

  $scope.selectExercise = (exercise) ->
    $scope.exercise = exercise
    if (exercise.history.length > 0)
      $scope.experience = exercise.history[..].pop().experience
    else
      $scope.experience = 0


    cal.update(exercise.history);
    cal.options.data = exercise.history;


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
          stats[entryDate].sum += e.experience
        else
          stats[entryDate] = {}
          stats[entryDate].counter = 1
          stats[entryDate].sum = e.experience

      for k,stat of stats
        average = stat.sum / stat.counter
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



