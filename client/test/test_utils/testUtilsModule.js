/*global angular, IS24, inject */
(function initOfferOverviewModule() {
    'use strict';
    angular
        .module('testing-utils', [])

        .value('version', 0.1)
        .factory('directiveHelperService', ['$rootScope', '$templateCache', function ($rootScope, $templateCache) {


            function compileAndDigest(snippet, scope) {
                var compiledDirective = null;
                inject(function ($compile, $rootScope) {

                        var elm = angular.element(snippet);
                        compiledDirective = $compile(elm)(scope);
                        $rootScope.$digest();
                    }
                );
                return compiledDirective;
            }

            function getElementBySelector(element, selector) {
                return element[0].querySelectorAll(selector);
            }

            function simulateClick(el) {
                var evt;
                if (document.createEvent) {
                    evt = document.createEvent("MouseEvents");
                    evt.initMouseEvent("click", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
                }
                if (evt) {
                    el.dispatchEvent(evt);

                } else if (el.click) {
                    el.click();
                } else {
                    throw 'no clicking event nor click method available';
                }
            }

            function addToTemplateCache(templateName, templateLocation) {
                if (!$templateCache.get(templateName)) {
                    $templateCache.put(templateName, window.__html__[ templateLocation]);
                }
            }

            function initializeTemplate(templateName, templateLocation) {

                if (templateName) {
                    addToTemplateCache(templateName, templateLocation);
                }

                return {
                    simulateClickOn: simulateClick,
                    compile: compileAndDigest,
                    getElementsByCssSelector: getElementBySelector
                };
            }

            return {
                init: initializeTemplate,
                addToTemplateCache: addToTemplateCache
            };

        }]);
}());
