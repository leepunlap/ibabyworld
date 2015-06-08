app.service('Session', function () {
    this.create = function (token, user) {
        this.token = token;
        this.user = user;
    };

    this.destroy = function () {
        this.token = null;
        this.user = null;
    };
})

app.filter('cmdate', [
    '$filter', function($filter) {
        return function(input, format) {
            return $filter('date')(new Date(input), format);
        };
    }
])

app.filter('capitalize', function() {
    return function(input, all) {
        return (!!input) ? input.replace(/([^\W_]+[^\s-]*) */g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();}) : '';
    }
})
