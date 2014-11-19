'use strict'

angular.module 'mtpApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'admin',
    url: '/admin'
    templateUrl: 'app/admin/admin.template.html'
    controller: 'AdminCtrl'
