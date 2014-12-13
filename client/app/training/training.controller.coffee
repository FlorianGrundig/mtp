'use strict'

angular.module 'mtpApp'
.controller 'TrainingCtrl', ($scope, $http, User, CategoryService, ExerciseService,$state) ->
  $scope.currentUser = User.get()
  $scope.categories = CategoryService.list()
  $scope.exercises = ExerciseService.list()


  $scope.selectExercise = (exercise) ->
    $state.go('training.exercise', {id: exercise._id})





