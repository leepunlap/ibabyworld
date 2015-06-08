class Api::V1::ProductImagesController < ApplicationController

  # Removing this line causes 422 "Unprocessable Entity Error"
  # It happens if we call the api request below without refreshing the page
  skip_before_action :verify_authenticity_token

  def create
    @productImage = ProductImage.new
    @productImage.cover = params[:cover]
    @productImage.product_id = params[:product_id]

    @productImage.save

    response_success({ :product_image => @productImage })
  end


  def show
    @pi = ProductImage.find(params[:id])
    render json: @pi.to_json(methods: [:cover_url_medium])
  end

  def destroy
    @pi = ProductImage.find(params[:id])

    @pi.destroy

    response_success()
  end
end
