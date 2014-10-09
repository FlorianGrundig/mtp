'use strict';

var LoginPage = function() {

  this.visit = function(){
    browser.get('/login');
  };


  this.form_is_visible = function(){
    return element(by.id('login_form')).isDisplayed();
  };

  function form_enter_email(email){
    element(by.model('user.email')).sendKeys(email);
  };

  this.form_enter_password = function(pw){
    element(by.model('user.password')).sendKeys(pw);
  };

  this.form_submit = function(){
    element(by.id('login_submit')).click();
  };

  this.getLoginToken = function(){
    var p = browser.manage().getCookie('token')
     p.then(function(cookie) {
      expect(cookie.value).toBeFalsy()
    });
  };

  this.login = function(email, pw){
    form_enter_email(email);
    this.form_enter_password(pw);
    this.form_submit();
  };

};

module.exports = new LoginPage();

