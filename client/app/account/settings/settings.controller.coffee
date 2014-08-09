'use strict'

angular.module 'mtpApp'
.controller 'SettingsCtrl', ($scope, User, Auth) ->
  $scope.errors = {}
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
