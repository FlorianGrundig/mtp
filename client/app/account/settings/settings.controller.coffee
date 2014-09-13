'use strict'

angular.module 'mtpApp'
.controller 'SettingsCtrl', ($scope, User, Auth, CategoryService, ExerciseService) ->
  $scope.errors = {}

  $scope.categories = CategoryService.list()
  $scope.exercises = ExerciseService.list()
  $scope.exercise =
    name: 'E1'
    categories: ['']
    source: 'any source'
    hints: ["a hint"]
    level: 10
    duration: 3
    max_experience: 100
    replay: 3
    training:
      times: 0
      experience: 1


  $scope.addHint = ->
    $scope.exercise.hints.push("")

  $scope.addCategory = ->
    $scope.exercise.categories.push("")

  $scope.createExercise = ->
    ExerciseService.create $scope.exercise


  $scope.newCategoryName = ''

  $scope.createNewCategory = ->
    CategoryService.create($scope.newCategoryName)
    $scope.categories = CategoryService.list()


  $scope.changePassword = (form) ->
    $scope.submitted = true

    if form.$valid
      Auth.changePassword $scope.user.oldPassword, $scope.user.newPassword
      .then ->
        $scope.message = 'Password successfully changed.'

      .catch ->
        form.password.$setValidity 'mongoose', false
        $scope.errors.other = 'Incorrect password'
        $scope.message = ''
