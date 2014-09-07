'use strict'

angular.module 'mtpApp'
.factory 'Category', ($resource) ->
  $resource '/api/category/:name',
    name: '@name'



angular.module 'mtpApp'
.factory 'CategoryService', (Category) ->

  create: (name) ->
    Category.save {
      name: name
    },
    (data) ->
      console.log("created category", data)
    return

  list: ->
    Category.query()
