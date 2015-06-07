app.controller('BBShopController', function($rootScope, $scope, $state) {
	$scope.viewItem = function() {
		$state.go('product-details');
	}

	//
	//	Products Dummy Data
	//
	$scope.products = []
	$scope.products.push({
		sku: 'product-001',
		tags: '6mo,thomas,',
		title: 'Thomas the Tank Engine',
		shortdesc: 'Best Learning Kit',
		longdesc: 'Explore the fascinating world of Thomas & Friends, Through the exciting adventures of Thomas the Tank Engine and his ...',
		price: 123.50
	})
	$scope.products.push({
		sku: 'product-002',
		tags: '11mo,9yo,lego,',
		title: 'Bandai Kyoryuger DX K...',
		shortdesc: 'Best Learning Kit',
		longdesc: 'Ages: 4+; Exclusive offer - FREE Kyoryuger Watch with purchase of any Kyoryuger items over $500. Please refer to in-store poster for details, While stock lasts...',
		price: 336.50
	})
	$scope.products.push({
		sku: 'product-003',
		tags: '24mo,mylittlepony,',
		title: 'Digital learning card',
		shortdesc: 'Best Learning Kit',
		longdesc: "The Nike Tailwind Loose Women's Running Tank Top is made with sweat-wicking fabric to help you stay dry and comfortable on your run.",
		price: 456.50
	})
	$scope.products.push({
		sku: 'product-004',
		tags: '24mo,10yo,frozen,monstersuniversity,',
		title: 'Thomas the Tank Engine',
		shortdesc: 'Best Learning Kit',
		longdesc: 'Explore the fascinating world of Thomas & Friends, Through the exciting adventures of Thomas the Tank Engine and his ...',
		price: 123.50
	})
	$scope.products.push({
		sku: 'product-005',
		tags: '2yo,barbie,',
		title: 'Bandai Kyoryuger DX K...',
		shortdesc: 'Best Learning Kit',
		longdesc: 'Ages: 4+; Exclusive offer - FREE Kyoryuger Watch with purchase of any Kyoryuger items over $500. Please refer to in-store poster for details, While stock lasts...',
		price: 336.50
	})
	$scope.products.push({
			sku: 'product-006',
			tags: '5yo,hotwheels,',
			title: 'Digital learning card',
			shortdesc: 'Best Learning Kit',
			longdesc: "The Nike Tailwind Loose Women's Running Tank Top is made with sweat-wicking fabric to help you stay dry and comfortable on your run.",
			price: 456.50
		})
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
	}

	$scope.showAll()

	//
	//	Shopping Cart
	//
	$scope.cart=[]
	
	$scope.Recalc = function() {
		$scope.total = 0
		for (var i in $scope.cart) {
			var item = $scope.cart[i]
			$scope.total += item.price * item.qty
		}
	}
	$scope.AddToCart = function(p) {
		var found=false
		for (var i in $scope.cart) {
			var item = $scope.cart[i]
			if (item.sku == p.sku) {
				item.qty += 1
				found = true;
			}
		}
		if (!found) {
			$scope.cart.push({
				sku:p.sku,
				desc:p.shortdesc,
				qty:1,
				price:p.price
			})				
		}
		$scope.Recalc()
	}
	$scope.MinusOneFromCart = function(p) {
		if (!p.qty) {
			p.qty = 1
		} else if (p.qty > 1) {
			p.qty--;
		}
		$scope.Recalc()
	}
	$scope.PlusOneFromCart = function(p) {
		if (!p.qty) {
			p.qty = 1
		} else {
			p.qty++
		}
		$scope.Recalc()
	}
	$scope.RemoveFromCart = function(p) {
		for (var i in $scope.cart) {
			var item = $scope.cart[i]
			if (item.sku == p.sku) {
				$scope.cart.splice(i,1)
			}
		}
		$scope.Recalc()
	}
});