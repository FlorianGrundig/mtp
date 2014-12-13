'use strict'

angular.module 'mtpApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'training',
    url: '/training',
    abstract: true,
    template: '<ui-view>'

  .state 'training.overview',
    url: '/overview'
    templateUrl: 'app/training/training.template.html'
    controller: 'TrainingCtrl'
    authenticate: true

  .state 'training.exercise',
    url: '/exercise/:id'
    templateUrl: 'app/training/training_exercise.template.html'
    controller: 'TrainingExerciseCtrl'
    authenticate: true
    resolve:
      exerciseData: ($http,$stateParams) ->
        $http({method: 'GET', url: '/api/exercise/' + $stateParams.id});


