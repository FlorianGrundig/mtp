'use strict'

angular.module 'mtpApp'
.controller 'NavbarCtrl', ($scope, $location, Auth) ->

  $scope.isLoggedIn = Auth.isLoggedIn

  $scope.logout = ->
    Auth.logout()
    $location.path '/login'

  $scope.isActive = (route) ->
    route is $location.path()