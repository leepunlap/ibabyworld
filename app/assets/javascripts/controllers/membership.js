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

    $http.get("http://localhost:3000/api/v1/sessions/profile").
    success(function(data) {
        console.log(data)
        // $scope.profile = data.member
        // $scope.profile.childs = data.details[0].childs
        // var addrstr = data.details[0].address
        // var contactstr = data.details[0].contact
        // $scope.profile.address = JSON.parse(addrstr)
        // $scope.profile.contact = JSON.parse(contactstr)[0]
    })



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