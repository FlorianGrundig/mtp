'use strict';

var LogoutPage = function() {

  this.visit = function(){
    browser.get('/logout');
  };

};

module.exports = new LogoutPage();

