app.controller('ArticleController', function ($rootScope, $scope, $state, $sanitize, $stateParams, $http, Data) {
    $scope.articleId = $stateParams.article;
    $scope.articles = null;
    $scope.article = null;

    console.log('iBaby scope name: '+ $rootScope.$state.name);
    console.log('Request url: '+ requestPath.articles);

	console.log('Selected article Id: '+ $stateParams.id);	

    if ($scope.articleId == undefined) {
    	Data.get(requestPath.articles).then(function (results) {
        	if (results.code == 200) {
            	console.log('Article response code: '+ results.code);

            	$scope.articles = results.body.articles;
        	}
    	});

    } else {
    	Data.get(requestPath.articles +'/'+ $scope.articleId).then(function (results) {
        	if (results.code == 200) {
            	$scope.article = results.body.article;
        	}
    	});
    }
});