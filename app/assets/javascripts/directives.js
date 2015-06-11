app.directive('focus', function() {
    	return function(scope, element) {
        	element[0].focus();
    	}      
	})

    .directive('onlyDigits', function () {
        return {
            require: 'ngModel',
            restrict: 'A',
                link: function (scope, element, attr, ctrl) {
                    function inputValue(val) {
                        if (val) {
                            var digits = val.replace(/[^0-9]/g, '');

                            if (digits !== val) {
                                ctrl.$setViewValue(digits);
                                ctrl.$render();
                            }
                            return parseInt(digits,10);
                        }
                        
                        return undefined;
                    }            
                ctrl.$parsers.push(inputValue);
            }
        };
    })

    .directive('ibabyBanner', function (Data) {
        return {
            restrict: 'E',
            template: '<p>{{test}}</p>',
            link: function (scope, element, attr, ctrl) {
                Data.get('banners').then(function(result) {
                    if (result.code === 200) {
                        scope.test = result.body;
                    }
                })
                
            }
        }
    })