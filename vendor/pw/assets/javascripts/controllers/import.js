app.controller('ImportController', function ($rootScope, $scope, $state, Upload, $activityIndicator, $timeout) {
// $activityIndicator.startAnimating();
    $scope.isComplete = false
	$scope.$watch('files', function () {
        $scope.upload($scope.files);
    });

	$scope.upload = function (files) {
         $scope.isComplete = false;

         if (files && files.length) {
            $activityIndicator.startAnimating();
            $scope.isProcessing = true;

            Upload.upload({
                url: urlService + requestPath.members + '/import',
                file: files[0]
            }).progress(function (evt) {
                var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
                console.log('progress: ' + progressPercentage + '% ');
                
            }).error(function (data, status, headers, config) {
                console.log('Error data Response: '+ data);

            }).success(function (data, status, headers, config) {
                $scope.showModal    = true;
                $scope.isProcessing = false;
                $scope.success      = data.data.success;
                $scope.errors       = data.data.errors;
                $scope.skipped      = data.data.existing;
                $timeout(function () {
                    $activityIndicator.stopAnimating();
                }, 3000);
                // console.log('Success data Response: '+ JSON.stringify(data.data));
            });
        }
    };

    $scope.open = function() {
        $scope.showModal = true;
    };

    $scope.ok = function() {
        $scope.showModal = false;
        $state.go($state.current, {}, {reload: true});
    };

    $scope.cancel = function() {
        $scope.showModal = false;
    };
});