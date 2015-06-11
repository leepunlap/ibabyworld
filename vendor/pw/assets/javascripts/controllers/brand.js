app.controller('BrandController', function ($rootScope, $scope, $state, $stateParams, $http, Data, Upload) {
    $scope.brands = [];
    $scope.checkedBrandIds = [];
    $scope.brand = {
        status: 0
    };

    $scope.dropzoneConfig = {
    'options': { // passed into the Dropzone constructor
        'paramName': 'image',
        'url': '/' + urlService + requestPath.brands + '/' + $stateParams.id + '/updateImage',
        'method': 'PUT'
    },
    'eventHandlers': {
      'sending': function (file, xhr, formData) {
      },
      'success': function (file, response) {
      }
    }
  };

    if ($state.current.name == "admin.brands") {
        // Get brands
        $http.get(urlService + requestPath.brands).success(function(data){
          $scope.brands = data;
        });
    } else if ($state.current.name == "admin.brands-edit") {
        // Get brand details
        $scope.brandId = $stateParams.id;

        console.log('Get brand Id: '+ requestPath.brands +'/'+ $scope.brandId);

        $http.get(urlService + requestPath.brands +'/'+ $scope.brandId).success(function(data){
          $scope.brand = data;
        });
    }

    $scope.doNewBrand = function () {
        $state.go('admin.brands-new')
    }

    $scope.checkStatus = function(status) {
        if (status == 0) return "Draft";
        if (status == 1) return "For Review";

        return "Published";
    }


    $scope.doDeleteBrand = function () {
        // console.log("I'm being clicked: "+ $scope.checkedBrandIds);
        angular.forEach($scope.checkedBrandIds, function(checked, brandId) {
            if (checked) {
                console.log('Deleting: '+ brandId);
                $http.delete(urlService + requestPath.brands + '/' + brandId).success(function (data) {
                      for( var index = 0; index < $scope.brands.length; index++ ) {
                          if ( $scope.brands[index].id === brandId ) {
                              $scope.brands.splice( index, 1 );
                              break;
                          }
                      }

                });
            }
        });
    }

    $scope.doDeleteSingleBrand = function (id) {
      $http.delete(urlService + requestPath.brands + '/' + id).success(function (data) {
        for( var index = 0; index < $scope.brands.length; index++ ) {
            if ( $scope.brands[index].id === id ) {
                $scope.brands.splice( index, 1 );
                break;
            }
        }
      });
    }

    $scope.doUpdateBrand = function (brand) {
        $scope.submitted = true;

        //if (!$scope.brandForm.$invalid) {
            $http.put(urlService + requestPath.brands + '/' + $scope.brandId, brand).success(function(data){
               $state.go('admin.brands');
             });
        //}
    };

    $scope.doCreateBrand = function (brand) {
        $scope.submitted = true;

        console.log('Submitting brand form');

        $http.post(urlService + requestPath.brands, brand).success(function(data){
          $state.go('admin.brands-edit', {id: data.id});
        });
    };


});
