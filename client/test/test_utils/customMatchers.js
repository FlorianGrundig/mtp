beforeEach(function(){


  this.addMatchers({

    toEqualAfterTrim: function(expected){
      var actual = this.actual || '';
        expected = expected.replace(/^\s+|\s+$/g, '');
        actual = actual.replace(/^\s+|\s+$/g, '');
      this.message = function(){
        return "Expected trimmed value '" + (actual) + "' to be '" + (expected)  + "'";
      };

      return actual === expected;
    },

    toEqualAfterNormalizedWhiteSpace: function(expected){
      "use strict";
      var actual = this.actual || '';
      actual  = actual.replace(/[\s][\s]*/g, " ").replace(/^[ \t]+|[ \t]+$/g,"");
      expected = expected.replace(/[\s][\s]*/g, " ").replace(/^[ \t]+|[ \t]+$/g,"");
      this.message = function(){
        return "Expected whitespace normalized value '"+ (actual) + "' to be '"+(expected) + "'";
      };
      return actual === expected;
    },

    toContainAfterNormalizedWhiteSpace: function(expected){
      "use strict";
      var actual = this.actual || '';
      actual  = actual.replace(/[\s][\s]*/g, " ").replace(/^[ \t]+|[ \t]+$/g,"");
      expected = expected.replace(/[\s][\s]*/g, " ").replace(/^[ \t]+|[ \t]+$/g,"");
      this.message = function(){
        return "Expected whitespace normalized value '"+ (actual) + "' to contain '"+(expected) + "'";
      };
      return actual.indexOf(expected) !== -1;

    }

  });
});