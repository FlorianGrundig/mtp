'use strict'

angular.module 'mtpApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'home',
    url: '/home'
    templateUrl: 'app/home/home.template.html'
    controller: 'HomeCtrl'
    authenticate: true
