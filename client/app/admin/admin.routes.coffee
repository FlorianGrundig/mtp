'use strict'

angular.module 'mtpApp'
.config ($routeProvider) ->
  $routeProvider
  .when '/admin',
    templateUrl: 'app/admin/admin.template.html'
    controller: 'AdminCtrl'
