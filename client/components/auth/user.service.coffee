'use strict'

angular.module 'mtpApp'
.factory 'User', ($resource) ->
  $resource '/api/users/:id/:controller',
    id: '@login'
  ,
    changePassword:
      method: 'PUT'
      params:
        controller: 'password'

    get:
      method: 'GET'
      params:
        id: 'me'

