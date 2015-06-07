app.controller('RegisterController', function ($rootScope, $scope, $state, $location, $http, $timeout, $stateParams, Data, countries) {
    var nowYear = date.getFullYear();

    $scope.token = $stateParams.token;   
    $scope.first_name = ''; 
    $scope.fields = [];
    $scope.years = [];
    $scope.days = [];
    $scope.months = months;
    $scope.childs = [0, 1, 2, 3, 4, 5];
    $scope.incomes = [
        { label: '$ 0.00 < $ 20,000', value:'19000.00' },
        { label: '$ 20,000 < $ 40,000', value:'39000.00' },
        { label: '$ 40,000 < $ 60,000', value:'59000.00'},
        { label: '$ 60,000 < $ 80,000', value:'79000.00' },
        { label: '$ 80,000 +', value:'80000.00' }
    ];

    $scope.types = [
        { label: 'Personal', value:0 },
        { label: 'Facebook Referral', value:1 },
        { label: 'Invitation', value:2 }
    ];

    $scope.contactDevices = [
        { 'label' : 'Phone', value: 'phone' },
        { 'label' : 'Mobile', value: 'mobile' }
    ];

    if ($scope.token) {
        $scope.first_name = $rootScope.loggedUser.first_name;
        $scope.submitted = true;
        $scope.successful = true;

        $timeout(function(){
            $state.go('home');
        }, 3000);
    }
    
    if ($state.current.name == "member.edit_profile") {
        var loggedUser = $rootScope.loggedUser;

        if (loggedUser) {
            $scope.member = {
                account_name: loggedUser.account_name == loggedUser.email ? "" : loggedUser.account_name,
                email: loggedUser.email,
                title: loggedUser.title,
                first_name: loggedUser.first_name,
                last_name: loggedUser.last_name,
            }
        }
    }


    // Load all countries
    // countries.list(function(countries) {
    //     $scope.countries = countries;
    //     $scope.member.country = $scope.countries[0].code;
    // });

    // Load years starting from 1940 to this year
    for (var x = nowYear; x > 1939 ; x--) {
        $scope.years.push(x);
    }

    // Load 31 days options
    for (var x = 1; x < 32 ; x++) {
        $scope.days.push(x);
    }

    $scope.$on('fillMemberForm', function(event, member){
        console.log('logged in', member);
        $scope.fill_provider = { provider: member.oauth_provider };
        $scope.member = member;
    });

    $scope.updateBirthdate = function(birth) {
        $scope.member.birth_date = birth.year +'-'+ birth.month +'-'+ birth.day;
    };

    $scope.changeChilds = function() {
        var num = $scope.member.details.childs.total;
        var num_labels = ['first', 'second', 'third', 'fourth', 'fifth'];
        
        $scope.fields = [];

        for (x = 0; x < num; x++) {
            $scope.fields.push({'id':'member.details.childs.age['+ x +']', label:num_labels[x]});
        }
    };

	$scope.doRegister = function (member) {
        $scope.member.locale = $rootScope.locale;
        $scope.submitted = true;
    
        $scope.registerForm.$setValidity('emailConflict', true);
        
        // console.log('Registering member info: '+ JSON.stringify(member));
        // return false;

        if (!$scope.registerForm.$invalid) {
            Data.post(requestPath.members +'/create', {
                member: member

            }).then(function (results) {
                if (results.code == 200) {
                    $scope.first_name  = $scope.member.first_name;
                    $scope.successful = true;

                    $(window).scrollTop(50);

                    var body = results.body;
                    
                    // $.each(body.member, function(key, value){
                    //     console.log('Parameters: '+ key +' : '+ value);
                    // });

                    $timeout(function(){
                        $state.go('home');
                        console.log('Switching to home page');
                    }, 3000);

                    console.log('success registration!');

                } else if (results.code == 409) {
                    $scope.registerForm.$setValidity('emailConflict', false);
                }
            });
        }
    };
});