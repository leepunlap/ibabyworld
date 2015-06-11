class Api::V1::BannersController < ApplicationController

  # Removing this line causes 422 "Unprocessable Entity Error"
  # It happens if we call the api request below without refreshing the banner
  skip_before_action :verify_authenticity_token

  def index
    @banner = Banner.all
    render json: @banner.to_json(include: [:tags])
  end

  def create
    @banner = Banner.new(post_params)
    @banner.tag_list = params[:tags].map{|t| t[:name]}
    @banner.save

    render json: @banner
  end

  def show
    @banner = Banner.find(params[:id])
    render json: @banner.to_json(include: [:tags], methods: [:image_url_medium])
  end

  def update
    @banner = Banner.find(params[:id])

    @banner.tag_list = params[:tags].map{|t| t[:name]}
    @banner.update_attributes!(post_params)

    render json: @banner
  end

  def updateImage
    @banner = Banner.find(params[:banner_id])
    @banner.update_attributes(image: params[:image])

    render json: @banner
  end

  def destroy
    @banner = Banner.find(params[:id])

    @banner.destroy

    response_success({})
  end

  def get_medium_images
    @a = Banner.find(params[:banner_id])
    render json: @a.banner_images.to_json(methods: [:image_url_medium])
  end

  private
  def post_params
    params.require(:banner).permit( :name, :order, :url, :tags, :locale, :description, :image )
  end
end
