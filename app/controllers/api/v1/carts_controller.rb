class Api::V1::CartsController < ApplicationController

	def allproducts
		products = Product.order('created_at desc')
		response_success({ :products => products })
	end

	def addproduct
		product = Product.create do |p|
			p.sku = params[:sku]
		end
		product.save
		if product.errors.any? == true
			response_validation_errors(product.errors.messages)
			return;
		end
		response_success({ :product => product })
	end

	def mycart
		if (params.has_key?(:memberid))
			cart = ShoppingCart.includes(:shopping_cart_items).find_or_create_by(member_id: params[:memberid])
		elsif (params.has_key?(:cookie))
			cart = ShoppingCart.includes(:shopping_cart_items).find_or_create_by(cookies: params[:cookie])
		else 
			cart = ShoppingCart.includes(:shopping_cart_items).find_or_create_by(cookies: 'ibabyworld')
		end
		response_success({ :cart => cart })	
	end

	def additemtocart
		if (params.has_key?(:cartid) and params.has_key?(:sku))
			cartitem = ShoppingCartItem.create do |i|
				i.shopping_cart_id = params[:cartid]
				# i.sku = params[:sku]
				# i.qty = params[:qty]
			end
			cartitem.save
			response_success({ :cartitem => cartitem })
		end
	end

	def changecartitemqty
		if (params.has_key?(:cartitemid))
			User.find(params[:cartitemid]) do |i|
				i.qty = params[:qty]
			end
		end
	end

	def removecartitem
		if (params.has_key?(:cartitemid))
			User.find(params[:cartitemid]).destroy
		end
	end

end