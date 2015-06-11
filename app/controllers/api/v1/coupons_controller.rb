class Api::V1::CouponsController < ApplicationController

  # Removing this line causes 422 "Unprocessable Entity Error"
  # It happens if we call the api request below without refreshing the coupon
  skip_before_action :verify_authenticity_token

  def index
    @coupon = Coupon.all
    render json: @coupon
  end

  def create
    @coupon = Coupon.new(post_params)

    @coupon.save

    render json: @coupon
  end

  def show
    @coupon = Coupon.find(params[:id])
    render json: @coupon.to_json(methods: [:cover_url_medium])
  end

  def update
    @coupon = Coupon.find(params[:id])

    @coupon.update_attributes!(post_params)

    render json: @coupon
  end

  def updateImage
    @coupon = Coupon.find(params[:coupon_id])
    @coupon.update_attributes(cover: params[:image])

    render json: @coupon
  end

  def destroy
    @coupon = Coupon.find(params[:id])

    @coupon.destroy

    response_success({})
  end

  def get_medium_images
    @a = Coupon.find(params[:coupon_id])
    render json: @a.coupon_images.to_json(methods: [:cover_url_medium])
  end

  private
  def post_params
    params.require(:coupon).permit(:coupon_id, :cover, :description_en_US, :description_zh_CN, :description_zh_HK,  :name_en_US, :name_zh_CN, :name_zh_HK )
  end
end
