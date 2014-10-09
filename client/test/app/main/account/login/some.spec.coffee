'use strict'

ddescribe 'describe 1', ->
  Auth = undefined

  beforeEach module 'mtpApp'

  beforeEach inject (_Auth_) ->
    Auth = _Auth_
    console.log('before 1')


  it 'should 1.1', ->
    expect(Auth).toBeDefined()
    console.log('it 1.1')



  describe 'describe 2', ->
    foo = undefined

    beforeEach  ->
      foo = {}
      console.log('before 2')

    it 'should 2.1', ->
      expect(foo).toBeDefined()
      console.log('it 2.1')


