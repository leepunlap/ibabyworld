app.controller('KidsFashionController', function ($rootScope, $scope, $state) {
	$scope.viewItem = function () {
		$state.go('kids-fashion-details');
	}
});