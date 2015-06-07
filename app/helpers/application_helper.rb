module ApplicationHelper

  def app_title
    ENV['APP_NAME']
  end

  def cms_title
    "Perpetual Wave"
  end

  def token
     session[:token]
  end

  def logged_member
    session[:member]
  end

  def user_token
     session[:user_token]
  end

  def logged_user
     session[:user]
  end

end
