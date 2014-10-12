'use strict'

describe 'Controller: LoginCtrl', ->
  Auth = scope = $httpBackend = page = undefined

  # load the controller's module
  beforeEach module 'mtpApp'
  beforeEach module 'app/account/login/login.template.html'
  beforeEach module 'loginPage'


  # Initialize the controller and a mock scope
  beforeEach inject (_Auth_, $controller, $rootScope, directiveHelperService, _$httpBackend_, loginPage) ->
    $httpBackend = _$httpBackend_
    Auth = _Auth_
    page = loginPage
    scope = $rootScope.$new()
    page.load_page(scope)

  #    dom = renderAndCompileLoginPage()


  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()


  describe 'login is successful', ->
    it 'should show welcome message and hide login form', ->
      auth_promise = mock_Auth()

      page.login('foo@bar.se', 'baz')
      fire_successful_login(auth_promise)

      expect(page.welcome_message()).toEqualAfterTrim("Hi ...")
      expect(page.login_form_visibility()).toBeFalsy()

    it 'should ask our api endpoint', ->
      $httpBackend.when('POST', '/auth/local').respond({});
      $httpBackend.when('GET', '/api/users/me').respond({role: "user"});

      page.login('foo@bar.se', 'baz')
      $httpBackend.flush()

      expect(page.welcome_message()).toEqualAfterTrim("Hi ...")
      expect(page.login_form_visibility()).toBeFalsy()


  describe 'login is not successful', ->
    it 'should provide scope method isLoggedIn which uses the Auth-service underneath', ->
      auth_promise = mock_Auth()

      page.login('foo@bar.se', 'baz')
      fire_unsuccessful_login(auth_promise, 'SOME ERROR')

      expect(page.welcome_message_visibility()).toBeFalsy()
      expect(page.server_error_message()).toEqualAfterTrim('SOME ERROR')


  ########################
  # suite helper functions
  ########################

  fire_successful_login = (auth_promise) ->
    auth_promise.resolve
    Auth.isLoggedIn.andReturn(true)
    scope.$apply()

  fire_unsuccessful_login = (auth_promise, msg) ->
    auth_promise.reject { message: msg}
    Auth.isLoggedIn.andReturn(false)
    scope.$apply()


  mock_Auth = ->
    deferred = undefined
    inject (_Auth_, $q) ->
      deferred = $q.defer()
      spyOn(_Auth_, 'login')
      spyOn(_Auth_, 'isLoggedIn')
      Auth = _Auth_
      _Auth_.login.andReturn(deferred.promise)
    deferred