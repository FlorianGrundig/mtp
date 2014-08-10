'use strict'

angular.module 'mtpApp'
.config ($routeProvider) ->
  $routeProvider
  .when '/',
    templateUrl: 'app/main/main.template.html'
    controller: 'MainCtrl'
