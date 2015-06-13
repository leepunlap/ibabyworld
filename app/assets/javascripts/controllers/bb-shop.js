app.controller('BBShopController', function($rootScope, $scope, $http, $state, $cookies, $window, $location) {

	var paymentid = $location.search()['paymentId']
	var paymenttoken = $location.search()['token']
	var payerid = $location.search()['PayerID']


	if (typeof(paymentid) != 'undefined') {
		$http.get('/api/v1/carts/executepaypal?paymentid='+paymentid+"&payerid="+payerid).
		success(function(data) {
			$scope.paymentinfo = data.payment
			console.log(data)
		})
	}

	$scope.viewItem = function() {
		$state.go('product-details');
	}

	$scope.createCartID = function() {
		var lowerCharacters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
		var numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
		var finalCharacters = lowerCharacters;
		finalCharacters = finalCharacters.concat(numbers);
		var passwordArray = [];
		for (var i = 1; i < 16; i++) {
			passwordArray.push(finalCharacters[Math.floor(Math.random() * finalCharacters.length)]);
		};
		return passwordArray.join("");
	};

	console.log("Get Cart")
	console.log($rootScope.isAuthorized)
	console.log($rootScope.loggedUser)


	//
	//	If logged in, get cart from member id
	//	If not logged in, get cartid, generate one and store in cookie if not exists.  Then get cart from cartid
	//
	if ($rootScope.isAuthorized) {
		//
		//	TODO : get shopping cart from member id
		//
		console.log("Member ID " + $rootScope.loggedUser.id)
	} else {
		var cartid = $cookies['cartid']
		if (cartid) {
			console.log("got cartid " + cartid)
			$scope.cartid = cartid
		} else {
			$cookies['cartid'] = $scope.createCartID()
			console.log("new cartid " + $cookies['cartid'])
		}
	}


	$http.get('/api/v1/products').
	success(function(data, status, headers, config) {
		$scope.products = data
		$scope.tags = data.tags
	})



	//
	//	Shopping Cart
	//
	$scope.Recalc = function() {
		$scope.total = 0
		for (var i in $scope.cart.shopping_cart_items) {
			var item = $scope.cart.shopping_cart_items[i]
			item.subtotal = (item.unit_price * item.qty).toFixed(2)
			$scope.total += item.unit_price * item.qty
		}
		$scope.total = $scope.total.toFixed(2)
	}
	$scope.cart = []
	$scope.refreshCart = function() {
		$http.get('/api/v1/carts/mycart').
		success(function(data) {
			$scope.cart = data
			$scope.Recalc()
		})
	}
	$scope.refreshCart()


	//
	//	Ageselect Tags
	//
	$scope.ageselect = []
	$scope.ageselect.push({
		tag: '6mo',
		desc: '0-6 months'
	})
	$scope.ageselect.push({
		tag: '11mo',
		desc: '7-11 months'
	})
	$scope.ageselect.push({
		tag: '24mo',
		desc: '12-24 months'
	})
	$scope.ageselect.push({
		tag: '2yo',
		desc: '0-2 years old'
	})
	$scope.ageselect.push({
		tag: '5yo',
		desc: '3-5 years old'
	})
	$scope.ageselect.push({
		tag: '9yo',
		desc: '6-9 years old'
	})
	$scope.ageselect.push({
		tag: '10yo',
		desc: '10 years old +'
	})

	//
	//	Kids Love Tags
	//
	$scope.whatkidslove = []
	$scope.whatkidslove.push({
		tag: 'lego',
		desc: 'Lego'
	})
	$scope.whatkidslove.push({
		tag: 'thomas',
		desc: 'Thomas'
	})
	$scope.whatkidslove.push({
		tag: 'mylittlepony',
		desc: 'My Little Pony'
	})
	$scope.whatkidslove.push({
		tag: 'frozen',
		desc: 'Frozen'
	})
	$scope.whatkidslove.push({
		tag: 'barbie',
		desc: 'Barbie'
	})
	$scope.whatkidslove.push({
		tag: 'hotwheels',
		desc: 'Hot Wheels'
	})
	$scope.whatkidslove.push({
			tag: 'monstersuniversity',
			desc: 'Monsters University'
		})
		//
		//	Pages Dummy Data
		//
	$scope.pages = [1, 2, 3, 4, 5]

	//
	//	Bread Crumbs
	//
	$scope.crumbs = ['Products', 'All']


	$scope.likeProduct = function(p) {
		if (!p.like) {
			p.like = true
		} else {
			p.like = false
		}
	}

	$scope.setTag = function(d, t) {
		$scope.detailmode=false
		$scope.tag = t.tag
		if (d == 1) {
			$scope.crumbs = ['Age', t.desc]
		} else if (d == 2) {
			$scope.crumbs = ['Category', t.desc]
		}
	}

	$scope.$watch('tag', function() {
		if ($scope.tag) {
			$scope.filtertext = ""
			$scope.filter = $scope.tag
		}

	});
	$scope.$watch('filtertext', function() {
		if ($scope.filtertext) {
			$scope.tag = ""
			$scope.filter = $scope.filtertext
			$scope.crumbs = ['Search', 'Results']
		}
	});
	$scope.showAll = function() {
		$scope.filter = ""
		$scope.filtertext = ""
	}

	$scope.showAll()

	$scope.AddToCart = function(p) {
		$scope.detailmode=false
		var found = false
		for (var i in $scope.cart.shopping_cart_items) {
			var item = $scope.cart.shopping_cart_items[i]
			if (item.product_id == p.id) {
				item.qty += 1
				found = true;
			}
		}
		if (!found) {
			$http.get('/api/v1/carts/additemtocart?cartid='+$scope.cart.id+"&productid="+p.id).
			success(function(data) {
				$scope.refreshCart()
			})
		}
	}
	$scope.MinusOneFromCart = function(p) {
		if (!p.qty) {
			newqty = 1
		} else if (p.qty > 1) {
			newqty = p.qty - 1
		}
		$http.get('/api/v1/carts/changecartitemqty/'+p.id+"/"+newqty).
		success(function(data) {
			console.log(data)
			$scope.refreshCart()
		})
	}
	$scope.PlusOneFromCart = function(p) {
		if (!p.qty) {
			newqty = 1
		} else {
			newqty = p.qty + 1
		}
		$http.get('/api/v1/carts/changecartitemqty/'+p.id+"/"+newqty).
		success(function(data) {
			console.log(data)
			$scope.refreshCart()
		})
	}
	$scope.RemoveFromCart = function(p) {
		$http.get('/api/v1/carts/removecartitem?cartitemid='+p.id).
		success(function(data) {
			$scope.refreshCart()
		})
	}
	$scope.detailmode = false
	$scope.showProductDetail = function(p) {
		$scope.selectedproduct=p
		$scope.detailmode=true
	}
	$scope.hideProductDetail = function() {
		$scope.detailmode=false
	}
	$scope.creatingpayment = false
	$scope.doPayPal = function() {
		console.log("Doing Paypal")
		$scope.creatingpayment = true;
		$http.get('/api/v1/carts/checkout').
		success(function(data) {
			$scope.creatingpayment = false
			$scope.paymentid = data.paymentid
			$scope.redirect = data.link
			$window.location.href = $scope.redirect
		})
		
	}
});
