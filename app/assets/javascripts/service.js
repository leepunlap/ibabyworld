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