app.controller('ArticleController', function ($rootScope, $scope, $state, $stateParams, $http, Data, Upload) {
    $scope.articles = [];
    $scope.checkedArticleIds = [];
    $scope.file = null;
    $scope.article = {
        status: 0
    };

    if ($state.current.name == "admin.articles") {
        // Get articles
        Data.get(requestPath.articles +'/all').then(function (results) {
            if (results.code == 200) {
                $scope.articles = results.body.articles;
            }
        });

    } else if ($state.current.name == "admin.articles-edit") {
        // Get article details
        $scope.articleId = $stateParams.id;        

        console.log('Get article Id: '+ requestPath.articles +'/'+ $scope.articleId);

        Data.get(requestPath.articles +'/'+ $scope.articleId).then(function (results) {

            if (results.code == 200) {
                $scope.article = results.body.article;

                if ($scope.article.tags.length > 0) {
                    var strings = $scope.article.tags.split(', ');
                    var tags = [];

                    $.each(strings, function(index, string){
                        tags.push({ text: string });
                        // console.log('Tag: '+ string);
                    });

                    $scope.article.tags = tags;
                }
            }
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

    $scope.getTags = function(string) {
        return string.split(', ');
    }

    $scope.doDeleteArticle = function () {
        // console.log("I'm being clicked: "+ $scope.checkedArticleIds);
        angular.forEach($scope.checkedArticleIds, function(checked, articleId) {
            if (checked) {
                console.log('Deleting: '+ articleId);

                Data.delete(requestPath.articles +'/'+ articleId +'/delete').then(function (results) {
                    if (results.code == 200) {
                        console.log('success registration!');

                        for( var index = 0; index < $scope.articles.length; index++ ) {
                            if ( $scope.articles[index].id === articleId ) {
                                $scope.articles.splice( index, 1 );
                                break;
                            }
                        }
                    }
                });
            }
        });
    }

    $scope.doUpdateArticle = function (article) {
        $scope.submitted = true;
    
        if (!$scope.articleForm.$invalid) {
            // Data.post(requestPath.articles +'/'+ $scope.articleId +'/update', {
            //     article: article

            // }).then(function (results) {
            //     if (results.code == 200) {
            //         $state.go('admin.articles');
                    
            //         // $.each(body.member, function(key, value){
            //         //     console.log('Parameters: '+ key +' : '+ value);
            //         // });

            //         console.log('success registration!');
            //     }
            // });
            Upload.upload({
                url: urlService + requestPath.articles +'/'+ $scope.articleId +'/update',
                fields: article,
                file: $scope.file
            }).progress(function (evt) {
                // var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
                // console.log('progress: ' + progressPercentage + '% ' + evt.config.file.name);

            }).error(function (data, status, headers, config) {
                console.log('Error data Response: '+ data);

            }).success(function (data, status, headers, config) {
                // console.log('file ' + config.file.name + 'uploaded. Response: ' + data);

                console.log('Success data Response: '+ data);
                $state.go('admin.articles');
            });
        }
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

    $scope.doCreateArticle = function (article) {
        $scope.submitted = true;
    
        console.log('Submitting article form');
        
        // if (!$scope.articleForm.$invalid) {
            Upload.upload({
                url: urlService + requestPath.articles +'/create',
                fields: article,
                file: $scope.file
            }).progress(function (evt) {
                // var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
                // console.log('progress: ' + progressPercentage + '% ' + evt.config.file.name);

            }).error(function (data, status, headers, config) {
                $.each(data, function(key, value){
                    console.log('Parameters: '+ key +' : '+ value);
                });

            }).success(function (data, status, headers, config) {
                // console.log('file ' + config.file.name + 'uploaded. Response: ' + data);

                console.log('Success data Response: '+ data);
                $state.go('admin.articles');
            });
    };
});