'use strict'

angular.module 'mtpApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'login',
    url: '/login'
    templateUrl: 'app/account/login/login.template.html'

  .state 'signup',
    url: '/signup'
    templateUrl: 'app/account/signup/signup.template.html'
    controller: 'SignupCtrl'

  .state 'settings',
    url: '/settings'
    templateUrl: 'app/account/settings/settings.template.html'
    controller: 'SettingsCtrl'
    authenticate: true
