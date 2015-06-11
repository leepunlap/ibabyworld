class Api::V1::PagesController < ApplicationController

  # Removing this line causes 422 "Unprocessable Entity Error"
  # It happens if we call the api request below without refreshing the page
  skip_before_action :verify_authenticity_token

  def index
    @page = Page.all
    render json: @page
  end

  def create
    @page = Page.new(post_params)

    @page.save

    response_success({ :page => @page })
  end

  def show
    @page = Page.find(params[:id])
    render json: @page
  end

  def update
    @page = Page.find(params[:id])

    @page.update_attributes(post_params)

    render json: @page
  end

  def destroy
    @page = Page.find(params[:id])

    @page.destroy

    response_success()
  end

  def get_medium_images
    @page = Page.find(params[:page_id])
    render json: @page.page_images.to_json(methods: [:image_url_medium])
  end

  private
  def post_params
    params.require(:page).permit!
  end
end
