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
          content = testHelper.compile($templateCache.get(templateName), scope)
        });
        return content
      }

      function enter_email() {

      }

      function load_page(scope) {
        testHelper = directiveHelperService.init();
        currentPage = renderAndCompileLoginTemplate(scope);
      }

      return {
        load_page: load_page,
        enter_email: enter_email

      };

    }]);
}());
