app.controller('MemberController', function ($rootScope, $scope, $state, $stateParams, $http, Data, Articles) {
    $scope.members = null;

    if ($state.current.name == "admin.members") {
        // Get all registered members
        console.log('Request url: '+ requestPath.members);

        Data.get(requestPath.members).then(function (results) {
            if (results.code == 200) {
                console.log('Article response code: '+ results.code);

                $scope.members = results.body.members;
            }
        });
    }
});