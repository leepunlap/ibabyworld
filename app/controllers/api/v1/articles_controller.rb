class Api::V1::ArticlesController < ApplicationController
  
  # Removing this line causes 422 "Unprocessable Entity Error" 
  # It happens if we call the api request below without refreshing the page
  skip_before_action :verify_authenticity_token

  def all
    articles = Article.limit(5).order('id desc')
    articles.each { |k| k[:poster] = "uploads/articles/#{k[:poster]}" }

  	response_success({ :articles => articles })
  end

  def list
    articles = Article.where(:status => '2').limit(5).order('id desc')
    articles.each { |k| k[:poster] = "uploads/articles/#{k[:poster]}" }

    response_success({ :articles => articles })
  end

  def detail
    article = Article.find_by_id(params[:id])

    if article == nil
      response_error_by_code(404)
      return
    end

    article[:poster] = "uploads/articles/#{article[:poster]}"

    response_success({ :article => article, tags: article.tag_list })
  end

  def get_tag_list
    @tags = ActsAsTaggableOn::Tagging.includes(:tag).where(taggable_type: 'Article').map { |tagging| { 'id' => tagging.tag_id.to_s, 'name' => tagging.tag.name } }.uniq
    response_success({ :tags => @tags })
  end

  def create
    begin
      # Article status (0 = draft, 1 = review, 2 = publish, 3 = hidden)
      article = Article.create do |a|
        a.title = params[:title]
        a.description = params[:description]
        a.content = params[:content]
        a.file = params[:file]
        #a.tags = tags_only(params[:tags])
        a.tag_list = params[:tags]
        a.status =  params[:status]
        a.published_by = params[:status] == "0" ? nil : 0
        a.created_by = 0
      end

      article.save

      if article.errors.any? == true
        response_validation_errors(article.errors.messages)
        return;
      end

      response_success({ :article => article })

    rescue => error
      response_error_body(error.message, 400)
    end
  end

  def update
    begin
      article = Article.find_by_id(params[:id]);

      if article == nil
        response_error_by_code(404)
        return
      end


      if !params[:file].nil?
        article.file = params[:file]
      end

      if article.status != 2
        article.published_by = params[:status] == "0" ? nil : 0
      end

      article.title = params[:title]
      article.description = params[:description]
      article.content = params[:content]
      #article.tags = tags_only(params[:tags])
      article.tag_list = params[:tags]
      article.status =  params[:status]

      article.save
    
      response_success({ :article => article })

    rescue => error
      response_error_body(error.message, 400)
    end
  end

  def delete
    article = Article.find_by_id(params[:id]);

    if article == nil
      response_error_by_code(404)
      return
    end

    article.delete

    response_success({ :article => article })
  end
end
