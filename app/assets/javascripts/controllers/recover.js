app.controller('RecoverController', function ($rootScope, $scope, $state, $location, $http, $timeout, $stateParams, Data, countries) {
    $scope.successfull = false;
    $scope.valid = 0;
    $scope.member = {
        new_password: '',
        email: '',
        uid: ''    
    }
    
    if ($state.current.name == 'password_reset') {
        $scope.member.email = $stateParams.email;
        $scope.member.uid = $stateParams.uid;

        $timeout(function(){
            Data.get(requestPath.members +'/password/reset?member[uid]='+ $stateParams.uid +'&member[email]='+ $stateParams.email).then(function (results) {
            $scope.valid = results.code;

            console.log('Validate reset authorization code: '+ results.code +' : '+ results.body.description);
        });

        }, 3000);
        
    }

    $scope.doReset = function (member) {
        $scope.submitted = true;
        $scope.resetForm.$setValidity('passwordNotMatch', true);

        if (!$scope.resetForm.$invalid) {
            if (member.new_password != member.confirm_password) {
                $scope.resetForm.$setValidity('passwordNotMatch', false);
                return false;
            }

            Data.post(requestPath.members +'/password/reset', {
                member: member

            }).then(function (results) {
                if (results.code == 200) {
                    $scope.member.email = "";
                    $scope.successfull = true;

                    $timeout(function(){
                        $state.go('home');
                    }, 3000);
                    
                    console.log('password recovery is successfull');
                }
            });
        }
    };

    $scope.doRecover = function (member) {
        $scope.submitted = true;
    
        if (!$scope.recoveryForm.$invalid) {
            Data.post(requestPath.members +'/password/recover', {
                member: member

            }).then(function (results) {
                if (results.code == 200) {
                    $scope.member.email = "";
                    $scope.submitted = false;
                    $scope.successfull = true;

                    console.log('password recovery is successfull');

                } else if (results.code == 404) {
                    console.log('Email not found')
                    $scope.recoveryForm.$setValidity('emailNotFound', false);
                }
            });
        }
    };
});