app.controller('ProductController', function ($rootScope, $scope, $state, $stateParams, $http, Data, Upload) {
    $scope.products = [];
    $scope.checkedProductIds = [];
    $scope.file = null;
    $scope.product = {
        status: 0
    };


    $scope.dropzoneConfig = {
    'options': { // passed into the Dropzone constructor
        'paramName': 'cover',
        'url': '/' + urlService + requestPath.productImages + '?product_id=' + $stateParams.id
    },
    'eventHandlers': {
      'sending': function (file, xhr, formData) {
        //console.log(file, xhr, formData);

      },
      'success': function (file, response) {
      }
    }
  };

    if ($state.current.name == "admin.products") {
        // Get products
        $http.get(urlService + requestPath.products).success(function(data){
          $scope.products = data;
        });
    } else if ($state.current.name == "admin.products-edit") {
        // Get product details
        $scope.productId = $stateParams.id;

        console.log('Get product Id: '+ requestPath.products +'/'+ $scope.productId);

        $http.get(urlService + requestPath.products +'/'+ $scope.productId).success(function(data){
          $scope.product = data;

          $http.get(urlService + requestPath.products + '/' + $scope.productId + '/medium-images').success(function(data){
            $scope.product_images = data;
            //console.log(data);
          });
        });
    }

    $scope.doNewProduct = function () {
        $state.go('admin.products-new')
    }

    $scope.checkStatus = function(status) {
        if (status == 0) return "Draft";
        if (status == 1) return "For Review";

        return "Published";
    }

    $scope.doDeleteProduct = function () {
        // console.log("I'm being clicked: "+ $scope.checkedproductIds);
        angular.forEach($scope.checkedProductIds, function(checked, productId) {
          if (checked) {
              console.log('Deleting: '+ productId);

              $http.delete(urlService + requestPath.products + '/' + productId).success(function (data) {

                    for( var index = 0; index < $scope.products.length; index++ ) {
                        if ( $scope.products[index].id === productId ) {
                            $scope.products.splice( index, 1 );
                            break;
                        }
                    }

              });
          }
        });
    }

    $scope.doDeleteSingleProduct = function (id) {
      $http.delete(urlService + requestPath.products + '/' + id).success(function (data) {
        for( var index = 0; index < $scope.products.length; index++ ) {
            if ( $scope.products[index].id === id ) {
                $scope.products.splice( index, 1 );
                break;
            }
        }
      });
    }

    $scope.doUpdateProduct = function (product) {
        $scope.submitted = true;

        // if (!$scope.productForm.$invalid) {
        //     // Data.post(requestPath.products +'/'+ $scope.productId +'/update', {
        //     //     product: product

        //     // }).then(function (results) {
        //     //     if (results.code == 200) {
        //     //         $state.go('admin.products');

        //     //         // $.each(body.member, function(key, value){
        //     //         //     console.log('Parameters: '+ key +' : '+ value);
        //     //         // });

        //     //         console.log('success registration!');
        //     //     }
        //     // });
        //     Upload.upload({
        //         url: urlService + requestPath.products +'/'+ $scope.productId +'/update',
        //         fields: product,
        //         file: $scope.file
        //     }).progress(function (evt) {
        //         // var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
        //         // console.log('progress: ' + progressPercentage + '% ' + evt.config.file.name);

        //     }).error(function (data, status, headers, config) {
        //         console.log('Error data Response: '+ data);

        //     }).success(function (data, status, headers, config) {
        //         // console.log('file ' + config.file.name + 'uploaded. Response: ' + data);

        //         console.log('Success data Response: '+ data);
        //         $state.go('admin.products');
        //     });
        // }
        //console.log(product.tags);
        $http.put(urlService + requestPath.products + '/' + $scope.productId, product).success(function(data){
           $state.go('admin.products');
        });
    };

    $scope.doCreateProduct = function (product) {
        $scope.submitted = true;

        console.log('Submitting product form');

        // if (!$scope.productForm.$invalid) {
            // Upload.upload({
            //     url: urlService + requestPath.products +'/create',
            //     fields: product,
            //     //file: $scope.file
            // }).progress(function (evt) {
            //     // var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
            //     // console.log('progress: ' + progressPercentage + '% ' + evt.config.file.name);

            // }).error(function (data, status, headers, config) {
            //     $.each(data, function(key, value){
            //         //console.log('Parameters: '+ key +' : '+ value);
            //         console.log(data);
            //     });

            // }).success(function (data, status, headers, config) {
            //     // console.log('file ' + config.file.name + 'uploaded. Response: ' + data);

            //     console.log('Success data Response: '+ data);
            //     $state.go('admin.products');
            // });

        // console.log(product.tags);
        $http.post(urlService + requestPath.products, product).success(function(data){
          $state.go('admin.products-edit', {id: data.id});
        });
    };

    $scope.deleteProductImage = function (id){
      Data.delete(requestPath.productImages + '/' + id).then(function(data,status){
        Data.get(requestPath.products + '/' + $scope.productId + '/medium-images').then(function (data){
          $scope.product_images = data.body;
        });
      });
    }
});
