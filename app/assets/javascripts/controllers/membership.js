app.controller('MembershipController', function ($scope, $rootScope, $http, $state, $cookies, AuthService) {

    if ($cookies['staysignedin'] === 'true') {
        $rootScope.member = {
            staysignedin : true
        }
    } else {
        $rootScope.member = {
            staysignedin : false
        }
    }

    $rootScope.getUserDetails()


    $scope.doLogin = function (login) {
        AuthService.login(login).then(function (member) {
            if (member == null) {
                $rootScope.member.password = '';
            } else {
                if ($rootScope.member.staysignedin) {
                    $cookies['staysignedin'] = 'true'
                    $cookies['email'] = $rootScope.member.email
                    $cookies['password'] = $rootScope.member.password
                } else {
                    $cookies['staysignedin'] = 'false'
                }
                $rootScope.isAuthorized = AuthService.isAuthorized();
                $rootScope.loggedUser = member;
                $rootScope.getUserDetails()
                
                // if ($rootScope.$lastState.name) {
                //     $state.go($rootScope.$lastState.name);
                // } else {
                //     $state.go('home');
                // }
            }
            console.log('Check isAuthorized : '+ $rootScope.isAuthorized);
        });
    };
});