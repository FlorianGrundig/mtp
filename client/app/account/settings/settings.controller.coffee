'use strict'

angular.module 'mtpApp'
.controller 'SettingsCtrl', ($scope, User, Auth, CategoryService) ->
  $scope.errors = {}

  $scope.exercises = []
  $scope.exercise =
    name: ''
    category: ''
    source: ''
    hints: [""]
    level: 0
    duration: 1
    max_experience: 10
    replay: 1
    training:
      times: 0
      experience: 0


  $scope.addHint = ->
    $scope.exercise.hints.push("")

  $scope.createExercise = ->
    'foo'

  $scope.categories = CategoryService.list()

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
        form.password.$setValidity 'reject', false
        $scope.errors.other = 'Incorrect password'
        $scope.message = ''
