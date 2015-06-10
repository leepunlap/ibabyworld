class Api::V1::PageImagesController < ApplicationController

  # Removing this line causes 422 "Unprocessable Entity Error"
  # It happens if we call the api request below without refreshing the page
  skip_before_action :verify_authenticity_token

  def create
    @pageImage = PageImage.new
    @pageImage.image = params[:image]
    @pageImage.page_id = params[:page_id]

    @pageImage.save

    response_success({ :page_image => @pageImage })
  end


  def show
    @pageImage = PageImage.find(params[:id])
    render json: @pageImage.to_json(methods: [:image_url_medium])
  end

  def destroy
    @pageImage = PageImage.find(params[:id])

    @pageImage.destroy

    response_success()
  end
end
