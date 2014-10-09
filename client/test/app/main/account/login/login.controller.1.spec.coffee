'use strict'

describe 'Controller: LoginCtrl (1)', ->
  location = Auth = controller = scope = undefined

  # load the controller's module
  beforeEach module 'mtpApp'


  # Initialize the controller and a mock scope
  beforeEach inject (_Auth_, $controller, $rootScope, $location) ->
    scope = $rootScope.$new()
    Auth = _Auth_
    location = $location
    spyOn(Auth, 'isLoggedIn')
    spyOn(Auth, 'login')
    spyOn(location, 'path')

    controller = $controller 'LoginCtrl',
      $scope: scope,
      Auth: Auth
      $location: location


  it 'should provide scope method isLoggedIn which uses the Auth-service underneath', ->
    Auth.isLoggedIn.andReturn("any return value")

    result = scope.isLoggedIn()

    expect(result).toBe("any return value")
    expect(Auth.isLoggedIn).toHaveBeenCalled()


  it 'should use Auth-service to login only if the form was successfully validated by angular', ->
    someLoginForm =
      $valid: false

    scope.login someLoginForm

    expect(Auth.login).not.toHaveBeenCalled()

  it 'should use user data to login via Auth-service', inject ($q) ->
    someLoginForm =
      $valid: true
    someUser = {email: "some@email.se", password: "some password"}
    scope.user = someUser
    deferred = $q.defer()

    Auth.login.andCallFake((user) ->
      expect(user).toEqual(someUser)
      deferred.promise
    )

    scope.login someLoginForm

    deferred.resolve()
    scope.$apply()

    expect(Auth.login).toHaveBeenCalled()
    expect(location.path).toHaveBeenCalledWith('/home')

# which test case is missing



