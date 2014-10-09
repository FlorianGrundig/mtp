'use strict'

describe 'Controller: LoginCtrl', ->
  Auth = scope = testHelper = dom = $httpBackend = undefined

  # load the controller's module
  beforeEach module 'mtpApp'
  beforeEach module 'app/account/login/login.template.html'
  beforeEach module 'testing-utils'


  # Initialize the controller and a mock scope
  beforeEach inject (_Auth_, $controller, $rootScope, directiveHelperService, _$httpBackend_) ->
    $httpBackend = _$httpBackend_
    Auth = _Auth_
    scope = $rootScope.$new()
    testHelper = directiveHelperService.init();
    dom = renderAndCompileLoginPage()


  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()


  describe 'login is successful', ->

    it 'should show welcome message and hide login form', ->
      auth_promise = mock_Auth()

      login_with('foo@bar.se', 'baz')
      fire_successful_login(auth_promise)

      expect(welcome_message()).toEqualAfterTrim("Hi ...")
      expect(login_form_visibility()).toBeFalsy()

    it 'should ask our api endpoint', ->
      $httpBackend.when('POST', '/auth/local').respond({});
      $httpBackend.when('GET', '/api/users/me').respond({role:"user"});

      login_with('foo@bar.se', 'baz')
      $httpBackend.flush()

      expect(welcome_message()).toEqualAfterTrim("Hi ...")
      expect(login_form_visibility()).toBeFalsy()


  describe 'login is not successful', ->

    it 'should provide scope method isLoggedIn which uses the Auth-service underneath', ->
      auth_promise = mock_Auth()

      login_with('foo@bar.se', 'baz')
      fire_unsuccessful_login(auth_promise, 'SOME ERROR')

      expect(welcome_message_visibility()).toBeFalsy()
      expect(server_error_message()).toEqualAfterTrim('SOME ERROR')



  ########################
  # suite helper functions
  ########################
  login_with = (email, pw) ->
    testHelper.getElementsByCssSelector(dom, "#login_email")[0].value = email
    testHelper.getElementsByCssSelector(dom, "#login_password")[0].value = pw
    angular.element(testHelper.getElementsByCssSelector(dom, "#login_email")[0]).triggerHandler('input')
    angular.element(testHelper.getElementsByCssSelector(dom, "#login_password")[0]).triggerHandler('input')
    submit_button = testHelper.getElementsByCssSelector(dom, "#login_submit")[0]
    testHelper.simulateClickOn submit_button

  fire_successful_login = (auth_promise) ->
    auth_promise.resolve
    Auth.isLoggedIn.andReturn(true)
    scope.$apply()

  fire_unsuccessful_login = (auth_promise, msg) ->
    auth_promise.reject { message: msg}
    Auth.isLoggedIn.andReturn(false)
    scope.$apply()


  welcome_message = ->
    if (welcome_message_visibility())
      testHelper.getElementsByCssSelector(dom, "#login_welcome")[0].innerHTML
    else
      undefined

  server_error_message = ->
    if (login_form_visibility())
      testHelper.getElementsByCssSelector(dom, "#login_server_error_msg")[0].innerHTML
    else
      undefined

  welcome_message_visibility = ->
    !angular.element(testHelper.getElementsByCssSelector(dom, "#login_welcome")[0]).hasClass('ng-hide')

  login_form_visibility = ->
    !angular.element(testHelper.getElementsByCssSelector(dom, "#login_form")[0]).hasClass('ng-hide')

  renderAndCompileLoginPage = ->
    content = undefined
    inject ($templateCache) ->
      content = testHelper.compile($templateCache.get('app/account/login/login.template.html'), scope)
    content

  mock_Auth =  ->
    deferred = undefined
    inject (_Auth_, $q) ->
      deferred = $q.defer()
      spyOn(_Auth_, 'login')
      spyOn(_Auth_, 'isLoggedIn')
      Auth = _Auth_
      _Auth_.login.andReturn(deferred.promise)
    deferred