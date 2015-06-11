app.controller('CouponController', function ($rootScope, $scope, $state, $stateParams, $http, Data, Upload) {
    $scope.coupons = [];
    $scope.checkedCouponIds = [];
    $scope.coupon = {
        status: 0
    };

    $scope.dropzoneConfig = {
    'options': { // passed into the Dropzone constructor
        'paramName': 'image',
        'url': '/' + urlService + requestPath.coupons + '/' + $stateParams.id + '/updateImage',
        'method': 'PUT'
    },
    'eventHandlers': {
      'sending': function (file, xhr, formData) {
      },
      'success': function (file, response) {
      }
    }
  };

    if ($state.current.name == "admin.coupons") {
        // Get coupons
        $http.get(urlService + requestPath.coupons).success(function(data){
          $scope.coupons = data;
        });
    } else if ($state.current.name == "admin.coupons-edit") {
        // Get coupon details
        $scope.couponId = $stateParams.id;

        console.log('Get coupon Id: '+ requestPath.coupons +'/'+ $scope.couponId);

        $http.get(urlService + requestPath.coupons +'/'+ $scope.couponId).success(function(data){
          $scope.coupon = data;
        });
    }

    $scope.doNewCoupon = function () {
        $state.go('admin.coupons-new')
    }

    $scope.checkStatus = function(status) {
        if (status == 0) return "Draft";
        if (status == 1) return "For Review";

        return "Published";
    }


    $scope.doDeleteCoupon = function () {
        // console.log("I'm being clicked: "+ $scope.checkedCouponIds);
        angular.forEach($scope.checkedCouponIds, function(checked, couponId) {
            if (checked) {
                console.log('Deleting: '+ couponId);
                $http.delete(urlService + requestPath.coupons + '/' + couponId).success(function (data) {
                      for( var index = 0; index < $scope.coupons.length; index++ ) {
                          if ( $scope.coupons[index].id === couponId ) {
                              $scope.coupons.splice( index, 1 );
                              break;
                          }
                      }

                });
            }
        });
    }

    $scope.doDeleteSingleCoupon = function (id) {
      $http.delete(urlService + requestPath.coupons + '/' + id).success(function (data) {
        for( var index = 0; index < $scope.coupons.length; index++ ) {
            if ( $scope.coupons[index].id === id ) {
                $scope.coupons.splice( index, 1 );
                break;
            }
        }
      });
    }

    $scope.doUpdateCoupon = function (coupon) {
        $scope.submitted = true;

        //if (!$scope.couponForm.$invalid) {
            $http.put(urlService + requestPath.coupons + '/' + $scope.couponId, coupon).success(function(data){
               $state.go('admin.coupons');
             });
        //}
    };

    $scope.doCreateCoupon = function (coupon) {
        $scope.submitted = true;

        console.log('Submitting coupon form');

        $http.post(urlService + requestPath.coupons, coupon).success(function(data){
          $state.go('admin.coupons-edit', {id: data.id});
        });
    };


});
