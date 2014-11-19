'use strict'

angular.module 'mtpApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'training',
    url: '/training'
    templateUrl: 'app/training/training.template.html'
    controller: 'TrainingCtrl'
    authenticate: true
