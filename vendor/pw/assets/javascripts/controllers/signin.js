app.controller('SigninController', function ($rootScope, $scope, $state, $stateParams, $http, Data, AuthService) {
    if ($state.current.name == "signin") {
        if (AuthService.isAuthorized() == true) {
            $state.go('admin.dashboard');
            return false;
        }
    }

    $scope.doSignin = function (user) {
        $scope.submitted = true;
        $scope.success = true;

        if (!$scope.loginForm.$invalid) {
            console.log('Signing in!');

            AuthService.login(user).then(function (user) {
                if (user == null) {
                    $scope.user.password = '';
                    $scope.success = false;

                } else {
                    $rootScope.isAuthorized = AuthService.isAuthorized();
                    $rootScope.loggedUser = user;
                    $state.go('admin.dashboard');
                }

                console.log('Check Authorization: '+ $rootScope.isAuthorized);
            });
        }
    };

    $scope.doSignout = function () {
        AuthService.destroy().then(function (results) {
            $rootScope.isAuthorized = AuthService.isAuthorized();
            $rootScope.loggedUser == null;

            $state.go('signin');
        });
    };
});