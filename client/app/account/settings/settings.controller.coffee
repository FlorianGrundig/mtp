'use strict'

angular.module 'mtpApp'
.controller 'SettingsCtrl', ($scope, User, Auth, CategoryService, ExerciseService) ->
  $scope.errors = {}

  $scope.categories = CategoryService.list()
  $scope.exercises = ExerciseService.list()
  default_new_execise =
    name: 'E1'
    categories: ['']
    source: 'any source'
    hints: "a hint"
    level: 10
    duration: 3
    max_experience: 5
    replay: 3
    history: []

  $scope.exercise = angular.copy default_new_execise


  matchingCategory = (id) ->
    id = id['_id'] || id
    for i in [0..$scope.categories.length]
      return $scope.categories[i] if $scope.categories[i]._id is id

  $scope.remove_cat = (idx) ->
    $scope.exercise.categories.splice(idx, 1)

  $scope.remove_history = (idx) ->
    $scope.exercise.history.splice(idx, 1)

  $scope.edit = (exercise) ->
    cats = []
    exercise.categories.forEach (id) ->
      cats.push(matchingCategory(id))

    exercise.categories = cats
    $scope.exercise = exercise

  $scope.addCategory = ->
    $scope.exercise.categories.push("")

  $scope.upsertExercise = ->
    ExerciseService.upsert $scope.exercise


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
