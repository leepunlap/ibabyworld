class Api::V1::SessionsController < ApplicationController
  
  # Removing this line causes 422 "Unprocessable Entity Error" 
  # It happens if we call the api request below without refreshing the page
  skip_before_action :verify_authenticity_token

  before_filter :check_authorization, :except => [:index, :show]

  def facebook_auth
    @access_token = params['access_token']
    @provider = params[:provider]
    @locale = params[:locale]

    begin
      facebook = FbGraph::User.me(@access_token.strip).fetch
      member = Member.find_by_oauth_uid(facebook.identifier)

      if member.nil?
        member = Member.create do |m|
          m.member_type = 0
          m.oauth_uid = facebook.identifier
          m.oauth_provider = @provider
          m.account_name = facebook.username == nil ? facebook.email : facebook.username
          m.new_password = @provider + facebook.identifier
          m.title = facebook.gender == "male" ? 0 : 1
          m.email =  facebook.email
          m.first_name = facebook.first_name
          m.last_name = facebook.last_name
          m.language = @locale
        end

        if member.save
          MemberMailer.email_confirmation(member, request.base_url).deliver_later(wait: 20.seconds)
        end
      end

      session[:token] = session[:token] == nil ? SecureRandom.hex : session[:token]
      session[:member] = member.to_hash

      response_success({ :token => session[:token], :member => member })

    rescue => error
      response_error_body(error.message, 400)
    end
  end

  def profile
    response_success({ :token => session[:token], :member => session[:member] })
  end

  def authenticate
    @member = params[:member]

    member = Member.authenticate(@member[:email], @member[:password])

    if member == nil
      response_error_by_code(404)
      return
    end

    session[:token] = session[:token] == nil ? SecureRandom.hex : session[:token]
    session[:member] = member.to_hash

    response_success({ :token => session[:token], :member => member })
  end

  def destroy
    reset_session
    # session[:token] = nil
    # session[:member] = nil
    # session[:user] = nil

    response_success(nil)
  end

  # Admin session handler

  def authenticate_user 
    @user = params[:user]

    if @user[:username] == "administrator" && @user[:password] == "pwapp14825"
      user = {
        :username => "administrator",
        :email => "admin@ibabyworld.com",
        :first_name => "Administrator",
        :last_name => ""
      }

      session[:user_token] = session[:user_token] == nil ? SecureRandom.hex : session[:user_token]
      session[:user] = user.to_hash

      response_success({ :token => session[:user_token], :user => user })
      return
    end

    response_error_by_code(401)
  end
  
end
