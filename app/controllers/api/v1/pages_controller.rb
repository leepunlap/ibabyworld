class Api::V1::PagesController < ApplicationController

  # Removing this line causes 422 "Unprocessable Entity Error"
  # It happens if we call the api request below without refreshing the page
  skip_before_action :verify_authenticity_token

  def create
    @page = Page.new(params[:page])

    @page.save

    response_success({ :page => @page })
  end

  def show
    @page = Page.find(params[:id])
    render json: @page
  end

  def update
    @page = Page.find(params[:id])

    @page.update_attributes(params[:page])

    render json: @page
  end

  def destroy
    @page = Page.find(params[:id])

    @page.destroy

    response_success()
  end
end
