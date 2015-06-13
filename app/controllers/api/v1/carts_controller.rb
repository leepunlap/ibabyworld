class Api::V1::CartsController < ApplicationController

	require 'paypal-sdk-rest'
	include PayPal::SDK::OpenIDConnect

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

	def checkout

		conf = PayPal::SDK.configure({
		  :mode => "sandbox",
		})

		@cart = ShoppingCart.find_or_create_by(cookies: 'ibabyworld') 

		@cartitems = ShoppingCartItem.where(shopping_cart_id: @cart.id )

		@payment = PayPal::SDK::REST::Payment.new({
		  :intent => "sale",
		  :payer => {
		    :payment_method => "paypal" },
		  :redirect_urls => {
		    :return_url => "http://localhost:3000/#/bb-shop/thankyou",
		    :cancel_url => "http://localhost:3000/#/bb-shop/cancel" },
		  :transactions => [ {
		    :amount => {
		      :currency => "HKD" },
		    :description => "iBabyWorld Purchase" } ] } )

		total=0
		itemno=0
		@cartitems.each do |i|
			@product = Product.find(i.product_id)
			name = @product.short_description_en_US
	       	@payment.transactions[0].item_list.items[itemno] = {
	                quantity: i.qty,
	                name: name,
	                price: '%.2f' % i.unit_price,
	                currency: 'HKD'
	            }
			total += i.unit_price.to_f * i.qty
			itemno += 1
		end

		@payment.transactions[0].amount.total = '%.2f' % total

		paymentresult = @payment.create
		@cart.update_attributes!({:paymentid => @payment.id, :paymenturl => @payment.links[1].href, :status => 1})
		@cart.save
  	

		render :json => { 
				:paymentid => @payment.id,
				:link => @payment.links[1].href,
				:success => paymentresult,
		    	:status => 'ok'
		    }.to_json
	end

	def executepaypal
		if (params.has_key?(:paymentid) and params.has_key?(:payerid))

			conf = PayPal::SDK.configure({
			  :mode => "sandbox",
			})
			@payment = PayPal::SDK::REST::Payment.find(params[:paymentid])
			@result = @payment.execute( :payer_id => params[:payerid] )

			render :json => { 
					:payment => @payment,
					:result => @result,
			    	:status => 'ok'
			    }.to_json
		end
	end

end