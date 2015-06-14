class Api::V1::ArticleImagesController < ApplicationController

  # Removing this line causes 422 "Unprocessable Entity Error"
  # It happens if we call the api request below without refreshing the page
  skip_before_action :verify_authenticity_token

  def create
    @articleImage = ArticleImage.new
    @articleImage.image = params[:image]
    @articleImage.article_id = params[:article_id]

    @articleImage.save

    response_success({ :article_image => @articleImage })
  end

  def update
    @articleImage = ArticleImage.find(params[:id])

    @articleImage.update_attributes!(post_params)

    render json: @articleImage
  end

  def show
    @articleImage = ArticleImage.find(params[:id])
    render json: @articleImage.to_json(methods: [:image_url_medium])
  end

  def destroy
    @articleImage = ArticleImage.find(params[:id])

    @articleImage.destroy

    response_success()
  end

  private
  def post_params
    params.require(:article_image).permit(:article_id, :image, :isCover)
  end
end
