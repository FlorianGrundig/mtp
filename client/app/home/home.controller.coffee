'use strict'

angular.module 'mtpApp'
.controller 'HomeCtrl', ($scope, $http, User) ->
  $scope.currentUser = User.get()
