app.controller('ProductController', function ($rootScope, $scope, $state, $stateParams, $http, Data, Upload) {
    $scope.products = [];
    $scope.checkedproductIds = [];
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
        Data.get(requestPath.products +'/all').then(function (results) {
            if (results.code == 200) {
                $scope.products = results.body.products;
            }
        });

    } else if ($state.current.name == "admin.products-edit") {
        // Get product details
        $scope.productId = $stateParams.id;

        console.log('Get product Id: '+ requestPath.products +'/'+ $scope.productId);

        Data.get(requestPath.products +'/'+ $scope.productId).then(function (results) {
            console.log(results.body);
            if (results.code == 200) {
                $scope.product = results.body.product;
                $scope.product.tags = results.body.tags;

                Data.get(requestPath.products + '/' + $scope.productId + '/medium-images').then(function (data){
                  $scope.product_images = data.body;
                });
                // var tags = [];
                // var str = "";
                // for (var i = 0; i < $scope.product.tags.length; i++){

                //     if (i + 1 == $scope.product.tags.length)
                //     {
                //         str += $scope.product.tags[i].name;
                //     }else
                //     {
                //         str += $scope.product.tags[i].name + ',';
                //     }
                // }
                //console.log(JSON.parse(str));
                //$scope.product.tags = JSON.parse(str);
            }
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

    $scope.getTags = function(string) {
        return string.split(', ');
    }

    $scope.doDeleteProduct = function () {
        // console.log("I'm being clicked: "+ $scope.checkedproductIds);
        angular.forEach($scope.checkedproductIds, function(checked, productId) {
            if (checked) {
                console.log('Deleting: '+ productId);

                Data.delete(requestPath.products +'/'+ productId +'/delete').then(function (results) {
                    if (results.code == 200) {
                        console.log('success registration!');

                        for( var index = 0; index < $scope.products.length; index++ ) {
                            if ( $scope.products[index].id === productId ) {
                                $scope.products.splice( index, 1 );
                                break;
                            }
                        }
                    }
                });
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
        var temp_str = '';
        product.tags.forEach(function(p){
            temp_str += p.text + ',';
           // console.log(p);
        });
        // console.log(temp_str);
        product.tags = temp_str;

        Data.post(requestPath.products+'/' + $scope.productId + '/update', product).then(function(data, status) {
            $state.go('admin.products');
        });
    };

    $scope.$watch('files', function () {
        $scope.upload($scope.files);
    });

    $scope.upload = function (files) {
         if (files && files.length) {
            var reader = new FileReader();

            $scope.file = files[0];

            reader.onload = function (e) {
                $('.preview img').attr('src', e.target.result);
            }

            reader.readAsDataURL($scope.file);
            return false;
        }
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
        var temp_str = '';
        product.tags.forEach(function(p){
            temp_str += p.text + ',';
            console.log(p);
        });
        // console.log(temp_str);
        product.tags = temp_str;

        Data.post(requestPath.products+'/create', product).then(function(data, status) {
            $state.go('admin.products-edit', {id: data.body.product.id});
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
