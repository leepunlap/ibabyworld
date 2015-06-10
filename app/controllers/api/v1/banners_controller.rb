class Api::V1::BannersController < ApplicationController

  # Removing this line causes 422 "Unprocessable Entity Error"
  # It happens if we call the api request below without refreshing the page
  skip_before_action :verify_authenticity_token

  def create
    @banner = Banner.new
    @banner.image = params[:image]

    @banner.save

    response_success({ :banner => @banner })
  end

  def show
    @banner = Banner.find(params[:id])
    render json: @banner.to_json(methods: [:image_url_medium])
  end

  def update
    @banner = Banner.find(params[:id])

    @banner.update_attributes(params[:banner])
  
    render json: @banner.to_json(methods: [:image_url_medium])
  end

  def destroy
    @banner = Banner.find(params[:id])

    @banner.destroy

    response_success()
  end
end
