app.factory("Data", ['$http', function ($http, toaster) {

        var obj = { body: {}, code: 400 };

        // Ensure request token is submitted to prevent CSRF attacks by raising an exception
        $http.defaults.headers.post["X-CSRF-Token"] = requestToken;

        obj.get = function (q) {
            return $http.get(urlService + q).then(function (results) {
                return { body: results.data, code: results.status };

            }, function(results) {
                return { body: results.data, code: results.status };
            });
        };
        obj.post = function (q, object) {
            console.log('Connection request: '+ urlService + q, object);
            return $http.post(urlService + q, object).then(function (results) {
                return { body: results.data, code: results.status };

            }, function(results) {
                return { body: results.data, code: results.status };
            });
        };
        obj.put = function (q, object) {
            return $http.put(urlService + q, object).then(function (results) {
                return { body: results.data, code: results.status };
                
            }, function(results) {
                return { body: results.data, code: results.status };
            });
        };
        obj.delete = function (q) {
            return $http.delete(urlService + q).then(function (results) {
                return { body: results.data, code: results.status };
            }, function(results) {
                return { body: results.data, code: results.status };
            });
        };

        return obj
}]);