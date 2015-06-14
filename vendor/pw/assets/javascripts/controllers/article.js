app.controller('ArticleController', function ($rootScope, $scope, $state, $stateParams, $http, Data, Upload) {
    $scope.articles = [];
    $scope.checkedArticleIds = [];
    $scope.article = {
        status: 0
    };

    $scope.dropzoneConfig = {
    'options': { // passed into the Dropzone constructor
        'paramName': 'image',
        'url': '/' + urlService + requestPath.articleImages + '?article_id=' + $stateParams.id
    },
    'eventHandlers': {
      'sending': function (file, xhr, formData) {
      },
      'success': function (file, response) {
      }
    }
  };

    if ($state.current.name == "admin.articles") {
        // Get articles
        $http.get(urlService + requestPath.articles).success(function(data){
          $scope.articles = data;
        });
    } else if ($state.current.name == "admin.articles-edit") {
        // Get article details
        $scope.articleId = $stateParams.id;

        console.log('Get article Id: '+ requestPath.articles +'/'+ $scope.articleId);

        $http.get(urlService + requestPath.articles +'/'+ $scope.articleId).success(function(data){
          $scope.article = data;

          $http.get(urlService + requestPath.articles + '/' + $scope.articleId + '/medium-images').success(function(data){
            $scope.article_images = data;
            //console.log(data);
          });
        });
    }

    $scope.doNewArticle = function () {
        $state.go('admin.articles-new')
    }

    $scope.checkStatus = function(status) {
        if (status == 0) return "Draft";
        if (status == 1) return "For Review";

        return "Published";
    }


    $scope.doDeleteArticle = function () {
        // console.log("I'm being clicked: "+ $scope.checkedArticleIds);
        angular.forEach($scope.checkedArticleIds, function(checked, articleId) {
            if (checked) {
                console.log('Deleting: '+ articleId);
                $http.delete(urlService + requestPath.articles + '/' + articleId).success(function (data) {
                      for( var index = 0; index < $scope.articles.length; index++ ) {
                          if ( $scope.articles[index].id === articleId ) {
                              $scope.articles.splice( index, 1 );
                              break;
                          }
                      }

                });
            }
        });
    }

    $scope.doDeleteSingleArticle = function (id) {
      $http.delete(urlService + requestPath.articles + '/' + id).success(function (data) {
        for( var index = 0; index < $scope.articles.length; index++ ) {
            if ( $scope.articles[index].id === id ) {
                $scope.articles.splice( index, 1 );
                break;
            }
        }
      });
    }

    $scope.doUpdateArticle = function (article) {
        $scope.submitted = true;

        //if (!$scope.articleForm.$invalid) {
            $http.put(urlService + requestPath.articles + '/' + $scope.articleId, article).success(function(data){
               $state.go('admin.articles');
             });
        //}
    };

    $scope.doCreateArticle = function (article) {
        $scope.submitted = true;

        console.log('Submitting article form');

        $http.post(urlService + requestPath.articles, article).success(function(data){
          $state.go('admin.articles-edit', {id: data.id});
        });
    };

    $scope.deleteArticleImage = function (id){
      Data.delete(requestPath.articleImages + '/' + id).then(function(data,status){
        Data.get(requestPath.articles + '/' + $scope.articleId + '/medium-images').then(function (data){
          $scope.article_images = data.body;
        });
      });
    }

    $scope.updateCover = function (ai) {
      $http.put(urlService + requestPath.articleImages + '/' + ai.id, ai).success(function(data){
        $state.go('admin.articles-edit', {id: data.article_id});
        //console.log(data);
      });
    }
});
