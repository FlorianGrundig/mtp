'use strict';

describe('Login View', function() {
  var loginPage;

  beforeEach(function() {
    loginPage = require('./login.po');
    browser.manage().deleteAllCookies();
    loginPage.visit();

  });

  it('should show login form', function() {
    expect(loginPage.form_is_visible()).toBeTruthy();
  });


  it('should hide login form when login successful', function() {
    loginPage.login('test@test.com', 'test');
    loginPage.visit();

    expect(loginPage.form_is_visible()).toBeFalsy();
  });

  it('should set cookie when login successful', function() {
    loginPage.login('test@test.com', 'test');

    browser.manage().getCookie('token').then(function(cookie) {
      expect(cookie.value).toBeTruthy()
    });
  });

  it('should show detailed error msg when password is wrong', function() {
    loginPage.login('test@test.com', 'password is wrong');

    element(by.id('login_server_error_msg')).then(function(el) {
      expect(el.getText()).toBe('This password is not correct.')
    });
  });

  it('should show detailed error msg when email is unknown to enable attacks', function() {
    loginPage.login('unkown@foo.com', 'password is wrong');

    element(by.id('login_server_error_msg')).then(function(el) {
      expect(el.getText()).toBe('This email is not registered.')
    });
  });

});
