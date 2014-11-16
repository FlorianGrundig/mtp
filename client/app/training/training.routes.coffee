'use strict'

angular.module 'mtpApp'
.config ($routeProvider) ->
  $routeProvider
  .when '/training',
    templateUrl: 'app/training/training.template.html'
    controller: 'TrainingCtrl'
    authenticate: true
