class Api::V1::ArticlesController < ApplicationController

  # Removing this line causes 422 "Unprocessable Entity Error"
  # It happens if we call the api request below without refreshing the article
  skip_before_action :verify_authenticity_token

  def index
    @article = Article.all
    render json: @article.to_json(include: [:tags])
  end

  def create
    @article = Article.new(post_params)

    @article.tag_list = params[:tags].map{|t| t[:name]}
    @article.save

    render json: @article
  end

  def show
    @article = Article.find(params[:id])
    render json: @article.to_json(include: [:tags])
  end

  def update
    @article = Article.find(params[:id])

    @article.tag_list = params[:tags].map{|t| t[:name]}
    @article.update_attributes!(post_params)

    render json: @article
  end

  def destroy
    @article = Article.find(params[:id])

    @article.destroy

    response_success({})
  end

  def get_medium_images
    @a = Article.find(params[:article_id])
    render json: @a.article_images.to_json(methods: [:image_url_medium])
  end

  private
  def post_params
    params.require(:article).permit(:article_id, :title, :description, :content, :status, :tags )
  end
end
