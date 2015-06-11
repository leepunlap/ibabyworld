app.controller('BannerController', function ($rootScope, $scope, $state, $stateParams, $http, Data, Upload) {
    $scope.banners = [];
    $scope.checkedBannerIds = [];

    $scope.dropzoneConfig = {
    'options': { // passed into the Dropzone constructor
        'paramName': 'image',
        'url': '/' + urlService + requestPath.banners + '/' + $stateParams.id + '/updateImage',
        'method': 'PUT'
    },
    'eventHandlers': {
      'sending': function (file, xhr, formData) {
      },
      'success': function (file, response) {
      }
    }
  };

    if ($state.current.name == "admin.banners") {
        // Get banners
        $http.get(urlService + requestPath.banners).success(function(data){
          $scope.banners = data;
        });
    } else if ($state.current.name == "admin.banners-edit") {
        // Get banner details
        $scope.bannerId = $stateParams.id;

        console.log('Get banner Id: '+ requestPath.banners +'/'+ $scope.bannerId);

        $http.get(urlService + requestPath.banners +'/'+ $scope.bannerId).success(function(data){
          $scope.banner = data;
          console.log(data);
        });
    }

    $scope.doNewBanner = function () {
        $state.go('admin.banners-new')
    }

    $scope.checkStatus = function(status) {
        if (status == 0) return "Draft";
        if (status == 1) return "For Review";

        return "Published";
    }


    $scope.doDeleteBanner = function () {
        // console.log("I'm being clicked: "+ $scope.checkedBannerIds);
        angular.forEach($scope.checkedBannerIds, function(checked, bannerId) {
            if (checked) {
                console.log('Deleting: '+ bannerId);
                $http.delete(urlService + requestPath.banners + '/' + bannerId).success(function (data) {
                      for( var index = 0; index < $scope.banners.length; index++ ) {
                          if ( $scope.banners[index].id === bannerId ) {
                              $scope.banners.splice( index, 1 );
                              break;
                          }
                      }

                });
            }
        });
    }

    $scope.doDeleteSingleBanner = function (id) {
      $http.delete(urlService + requestPath.banners + '/' + id).success(function (data) {
        for( var index = 0; index < $scope.banners.length; index++ ) {
            if ( $scope.banners[index].id === id ) {
                $scope.banners.splice( index, 1 );
                break;
            }
        }
      });
    }

    $scope.doUpdateBanner = function (banner) {
        $scope.submitted = true;

        //if (!$scope.bannerForm.$invalid) {
            $http.put(urlService + requestPath.banners + '/' + $scope.bannerId, banner).success(function(data){
               $state.go('admin.banners');
             });
        //}
    };



    $scope.doCreateBanner = function (banner) {
        $scope.submitted = true;

        console.log('Submitting banner form');
        $http.post(urlService + requestPath.banners, banner).success(function(data){
          $state.go('admin.banners-edit', {id: data.id});
        });


    };


});
