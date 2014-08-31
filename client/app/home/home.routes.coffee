'use strict'

angular.module 'mtpApp'
.config ($routeProvider) ->
  $routeProvider
  .when '/home',
    templateUrl: 'app/home/home.template.html'
    controller: 'HomeCtrl'
    authenticate: true
