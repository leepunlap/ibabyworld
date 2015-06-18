app.controller('ArticleController', function ($rootScope, $scope, $state, $sanitize, $stateParams, $http, Data) {
    $scope.articleId = $stateParams.article;
    $scope.articles = null;
    $scope.article = null;

    console.log('iBaby scope name: '+ $rootScope.$state.name);
    console.log('Request url: '+ requestPath.articles);

	console.log('Selected article Id: '+ $stateParams.id);

    if ($scope.articleId == undefined) {
    	// Data.get(requestPath.articles).then(function (results) {
      //   	if (results.code == 200) {
      //       	console.log('Article response code: '+ results.code);
      //
      //       	$scope.articles = results.body.articles;
      //   	}
    	// });
      $http.get('/api/v1/' + requestPath.articles).success(function(data){
        $scope.articles = data;
        // console.log($scope.articles[0].id);
        $scope.articles.forEach(function(a){
          $http.get('/api/v1/' + requestPath.articles + '/' + a.id + '/medium-images').success(function(data){
            a.image = data;
            if (data.length <= 0){
              a.image = [{image_url_medium: '/default.png'}];
            }
          });
        });
      });

      //console.log($scope.articles);
    } else {
    	// Data.get(requestPath.articles +'/'+ $scope.articleId).then(function (results) {
      //   	if (results.code == 200) {
      //       	$scope.article = results.body.article;
      //   	}
    	// });
      $http.get('/api/v1/' + requestPath.articles +'/'+ $scope.articleId).success(function(data){
        $scope.article = data;
        $http.get('/api/v1/' + requestPath.articles + '/' + $scope.article.id + '/medium-images').success(function(data){
          $scope.article.image = data;
          if (data.length <= 0){
            $scope.article.image = [{image_url_medium: '/default.png'}];
          }
        });
      });
    }
});
