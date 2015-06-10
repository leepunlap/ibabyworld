class Api::V1::BrandsController < ApplicationController

  # Removing this line causes 422 "Unprocessable Entity Error"
  # It happens if we call the api request below without refreshing the page
  skip_before_action :verify_authenticity_token

  def create
    @brand = Brand.new
    @brand.cover = params[:cover]

    @brand.save

    response_success({ :brand => @brand })
  end

  def show
    @brand = Brand.find(params[:id])
    render json: @brand.to_json(methods: [:cover_url_medium])
  end

  def update
    @brand = Brand.find(params[:id])

    @brand.update_attributes(params[:brand])

    render json: @brand.to_json(methods: [:cover_url_medium])
  end

  def destroy
    @brand = Brand.find(params[:id])

    @brand.destroy

    response_success()
  end
end
