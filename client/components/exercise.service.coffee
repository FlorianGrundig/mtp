'use strict'

angular.module 'mtpApp'
.factory 'Exercise', ($resource) ->
  $resource '/api/exercise/:id',
    name: '@id'




angular.module 'mtpApp'
.factory 'ExerciseService', (Exercise) ->

  create: (prop) ->
    Exercise.save prop
    ,
    (data) ->
      console.log("created exercise", data)
    return

  list: ->
    Exercise.query()
