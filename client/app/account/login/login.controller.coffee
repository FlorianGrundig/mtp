'use strict'

angular.module 'mtpApp'
.controller 'LoginCtrl', ($scope, Auth, $state, $window) ->
  $scope.user = {}
  $scope.errors = {}

  $scope.isLoggedIn = ->
    Auth.isLoggedIn()

  $scope.login = (form) ->
    $scope.submitted = true

    if form.$valid
      # Logged in, redirect to home
      Auth.login
        email: $scope.user.email
        password: $scope.user.password

      .then ->
        $state.go "home"

      .catch (err) ->
        $scope.errors.other = err.message

