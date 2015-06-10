class Api::V1::CouponsController < ApplicationController

  # Removing this line causes 422 "Unprocessable Entity Error"
  # It happens if we call the api request below without refreshing the page
  skip_before_action :verify_authenticity_token

  def create
    @coupon = Coupon.new
    @coupon.cover = params[:cover]

    @coupon.save

    response_success({ :coupon => @coupon })
  end

  def show
    @coupon = Coupon.find(params[:id])
    render json: @coupon.to_json(methods: [:cover_url_medium])
  end

  def update
    @coupon = Coupon.find(params[:id])

    @coupon.update_attributes(params[:coupon])

    render json: @coupon.to_json(methods: [:cover_url_medium])
  end

  def destroy
    @coupon = Coupon.find(params[:id])

    @coupon.destroy

    response_success()
  end
end
