class Api::V1::CartsController < ApplicationController

	def mycart
		if (params.has_key?(:memberid))
			cart = ShoppingCart.find_or_create_by(member_id: params[:memberid])
		elsif (params.has_key?(:cookie))
			cart = ShoppingCart.find_or_create_by(cookies: params[:cookie])
		else 
			cart = ShoppingCart.find_or_create_by(cookies: 'ibabyworld')
		end
		render json: cart.to_json(include: [:shopping_cart_items])	
	end

	def additemtocart
		if (params.has_key?(:cartid) and params.has_key?(:productid))
			@product = Product.find(params[:productid])
			cartitem = ShoppingCartItem.create do |i|
				i.shopping_cart_id = params[:cartid]
				i.product_id = params[:productid]
				i.qty = 1
				i.unit_price = @product.unit_price
			end
			cartitem.save
			response_success({ :cartitem => cartitem })
		end
	end

	def changecartitemqty
		if (params.has_key?(:cartitemid))
			# cartitem = ShoppingCartItem.find(params[:cartitemid]) do |i|
			# 	i.qty = params[:qty]
			# end
			cartitem = ShoppingCartItem.find(params[:cartitemid])
			cartitem.update_attributes(qty: params[:qty])
			render :json => { 
			      :status => 'ok',
			      :cartitem => cartitem 
			    }.to_json
		end
	end

	def removecartitem
		if (params.has_key?(:cartitemid))
			ShoppingCartItem.find(params[:cartitemid]).destroy
			render :json => { 
			      :status => 'ok'
			    }.to_json
		end
	end

end