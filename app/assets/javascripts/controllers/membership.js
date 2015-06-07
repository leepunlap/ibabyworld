app.controller('MembershipController', function ($scope, $rootScope, $state, $http, AuthService, Session) {
    // we will store all of our form data in this object
    $scope.formData = {};

    $scope.doLogin = function (login) {
        $scope.submitted = true;
        $scope.success = true;

        AuthService.login(login).then(function (member) {
            if (member == null) {
                $scope.member.password = '';
                $scope.success = false;

            } else {
                $rootScope.isAuthorized = AuthService.isAuthorized();
                $rootScope.loggedUser = member;
                $state.go('member.edit_profile');
            }

            console.log('Check Authorization: '+ $rootScope.isAuthorized);
        });
    };
});