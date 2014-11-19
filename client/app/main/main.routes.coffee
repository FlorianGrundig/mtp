'use strict'

angular.module 'mtpApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'main',
    templateUrl: 'app/main/main.template.html'
    controller: 'MainCtrl'
    url: '/'
