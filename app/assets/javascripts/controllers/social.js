app.controller('SocialController', function ($rootScope, $scope, $state, $location, $http, Data, Session, AuthService) {
    $rootScope.doFacebookLogin = function () {
        console.log('Login using facebook');
    
        // FB.getLoginStatus(function(response) {
        //     console.log('Facebook login status: '+ response.status);
        //     // if (response.status === 'connected') {
        //     //     console.log('Logged in.');
        //     // } else {
        //     //     FB.login();
        //     // }
        // });

        FB.login(function(response) {
            if (response.authResponse) {
                var access_token = FB.getAuthResponse()['accessToken'];
                
                Data.post(requestPath.sessions.facebook_auth, {
                    access_token: access_token,
                    locale: $rootScope.locale,
                    provider: "facebook"

                }).then(function (results) {
                    console.log('Facebook connection response: '+ results.code);

                    if (results.code == 200) {
                        console.log('Facebook user is now login');

                        // $.each(results.body.member, function(key, value){
                        //     console.log('Parameters: '+ key +' : '+ value);
                        // });

                        // $rootScope.$broadcast('fillMemberForm', $scope.member);
                        Session.create(results.body.token, results.body.member);

                        $rootScope.isAuthorized = AuthService.isAuthorized();
                        $rootScope.loggedUser = results.body.member;

                        $state.go('register', { token: access_token });

                    } else {
                        console.log('Request error: '+ results.body.description);
                    }
                });

            } else {
                console.log('User cancelled login or did not fully authorize.');
            }
        }, {
            scope: 'email, public_profile, user_friends, publish_actions'
        });
    };
});