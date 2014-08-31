'use strict'

angular.module 'mtpApp'
.controller 'AdminCtrl', ($scope, $http, Auth, User) ->

  # Use the User $resource to fetch all users
  $scope.users = User.query()

  $scope.delete = (user) ->
    User.remove login: user.login
    angular.forEach $scope.users, (u, i) ->
      $scope.users.splice i, 1 if u is user
