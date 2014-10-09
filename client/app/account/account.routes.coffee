'use strict'

angular.module 'mtpApp'
.config ($routeProvider) ->
  $routeProvider
  .when '/login',
    templateUrl: 'app/account/login/login.template.html'

  .when '/signup',
    templateUrl: 'app/account/signup/signup.template.html'
    controller: 'SignupCtrl'

  .when '/settings',
    templateUrl: 'app/account/settings/settings.template.html'
    controller: 'SettingsCtrl'
    authenticate: true
