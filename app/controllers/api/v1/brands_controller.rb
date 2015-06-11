class Api::V1::BrandsController < ApplicationController

  # Removing this line causes 422 "Unprocessable Entity Error"
  # It happens if we call the api request below without refreshing the brand
  skip_before_action :verify_authenticity_token

  def index
    @brand = Brand.all
    render json: @brand
  end

  def create
    @brand = Brand.new(post_params)

    @brand.save

    render json: @brand
  end

  def show
    @brand = Brand.find(params[:id])
    render json: @brand.to_json(methods: [:cover_url_medium])
  end

  def update
    @brand = Brand.find(params[:id])

    @brand.update_attributes!(post_params)

    render json: @brand
  end

  def updateImage
    @brand = Brand.find(params[:brand_id])
    @brand.update_attributes(cover: params[:image])

    render json: @brand
  end

  def destroy
    @brand = Brand.find(params[:id])

    @brand.destroy

    response_success({})
  end

  def get_medium_images
    @a = Brand.find(params[:brand_id])
    render json: @a.brand_images.to_json(methods: [:cover_url_medium])
  end

  private
  def post_params
    params.require(:brand).permit(:brand_id, :name_en_US, :name_zh_CN, :name_zh_HK, :cover )
  end
end
