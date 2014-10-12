/*global angular, IS24, inject */
(function loginPageModule() {
  'use strict';
  angular
    .module('loginPage', ['testing-utils'])

    .factory('loginPage', ['directiveHelperService', function (directiveHelperService) {
      var testHelper, currentPage;

      function renderAndCompileLoginTemplate(scope) {
        var content = undefined;
        inject(function ($templateCache) {
          content = testHelper.compile($templateCache.get('app/account/login/login.template.html'), scope)
        });
        return content
      }

      function login(email, pw) {
        testHelper.getElementsByCssSelector(currentPage, "#login_email")[0].value = email;
        testHelper.getElementsByCssSelector(currentPage, "#login_password")[0].value = pw;
        angular.element(testHelper.getElementsByCssSelector(currentPage, "#login_email")[0]).triggerHandler('input');
        angular.element(testHelper.getElementsByCssSelector(currentPage, "#login_password")[0]).triggerHandler('input');
        var submit_button = testHelper.getElementsByCssSelector(currentPage, "#login_submit")[0];
        testHelper.simulateClickOn(submit_button);

      }

      function load_page(scope) {
        testHelper = directiveHelperService.init();
        currentPage = renderAndCompileLoginTemplate(scope);
      }


      function welcome_message() {
        if (welcome_message_visibility())
          return testHelper.getElementsByCssSelector(currentPage, "#login_welcome")[0].innerHTML;
        else
          return undefined
      }

      function server_error_message() {
        if (login_form_visibility())
          return testHelper.getElementsByCssSelector(currentPage, "#login_server_error_msg")[0].innerHTML;
        else
          return undefined
      }


      function welcome_message_visibility() {
        return !angular.element(testHelper.getElementsByCssSelector(currentPage, "#login_welcome")[0]).hasClass('ng-hide')
      }


      function login_form_visibility() {
        return !angular.element(testHelper.getElementsByCssSelector(currentPage, "#login_form")[0]).hasClass('ng-hide')
      }


      return {
        load_page: load_page,
        login: login,
        welcome_message: welcome_message,
        server_error_message: server_error_message,
        welcome_message_visibility: welcome_message_visibility,
        login_form_visibility: login_form_visibility
      };

    }]);
}());
