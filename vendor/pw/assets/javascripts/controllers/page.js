app.controller('PageController', function ($rootScope, $scope, $state, $stateParams, $http, Data, Upload) {
    $scope.pages = [];
    $scope.checkedPageIds = [];
    $scope.file = null;
    $scope.page = {
        status: 0
    };

    $scope.dropzoneConfig = {
      'options': { // passed into the Dropzone constructor
          'paramName': 'image',
          'url': '/' + urlService + requestPath.pageImages + '?page_id=' + $stateParams.id
      },
      'eventHandlers': {
        'sending': function (file, xhr, formData) {
        },
        'success': function (file, response) {
        }
      }
    };

    if ($state.current.name == "admin.pages") {
        // Get pages
        $http.get(urlService + requestPath.pages).success(function(data){
          $scope.pages = data;
        });

    } else if ($state.current.name == "admin.pages-edit") {
        // Get page details
        $scope.pageId = $stateParams.id;

        console.log('Get page Id: '+ requestPath.pages +'/'+ $scope.pageId);

        $http.get(urlService + requestPath.pages +'/'+ $scope.pageId).success(function(data){
          $scope.page = data;
          $http.get(urlService + requestPath.pages + '/' + $scope.pageId + '/medium-images').success(function(data){
            $scope.page_images = data;
          });
        });

        // Data.get(requestPath.pages +'/'+ $scope.pageId).then(function (results) {
        //
        //     if (results.code == 200) {
        //         $scope.page = results.body.page;
        //         //$scope.page.tags = results.body.tags;
        //         //console.log($scope.page);
        //         Data.get(requestPath.pages + '/' + $scope.pageId + '/medium-images').then(function (data){
        //           $scope.page_images = data.body;
        //           console.log(data);
        //         });
        //
        //     }
        // });
    }

    $scope.doNewPage = function () {
        $state.go('admin.pages-new')
    }

    $scope.checkStatus = function(status) {
        if (status == 0) return "Draft";
        if (status == 1) return "For Review";

        return "Published";
    }


    $scope.doDeletePage = function () {
        // console.log("I'm being clicked: "+ $scope.checkedPageIds);
        angular.forEach($scope.checkedPageIds, function(checked, pageId) {
          if (checked) {
              console.log('Deleting: '+ pageId);
              $http.delete(urlService + requestPath.pages + '/' + pageId).success(function (data) {
                    for( var index = 0; index < $scope.pages.length; index++ ) {
                        if ( $scope.pages[index].id === pageId ) {
                            $scope.pages.splice( index, 1 );
                            break;
                        }
                    }

              });
          }
        });
    }

    $scope.doDeleteSinglePage = function (id) {
      $http.delete(urlService + requestPath.pages + '/' + id).success(function (data) {
        for( var index = 0; index < $scope.pages.length; index++ ) {
            if ( $scope.pages[index].id === id ) {
                $scope.pages.splice( index, 1 );
                break;
            }
        }
      });
    }

    $scope.doUpdatePage = function (page) {
        $scope.submitted = true;

        // if (!$scope.pageForm.$invalid) {
        //
        // }

        $http.put(urlService + requestPath.pages + '/' + $scope.pageId, page).success(function(data){
          $state.go('admin.pages');
        });
    };

    $scope.doCreatePage = function (page) {
        $scope.submitted = true;

        console.log('Submitting page form');

        $http.post(urlService + requestPath.pages, page).success(function(data){
          $state.go('admin.pages-edit', {id: data.page.id});
          //console.log(data);
        });
    };
});
