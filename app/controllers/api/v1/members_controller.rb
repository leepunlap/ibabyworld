class Api::V1::MembersController < ApplicationController

  include GlobalHelper

  # Removing this line causes 422 "Unprocessable Entity Error" 
  # It happens if we call the api request below without refreshing the page
  skip_before_action :verify_authenticity_token

  def list
    members = Member.order('created_at desc')

    response_success({ :members => members })
  end

  def create
    @member = params[:member]
  
    member = Member.create do |m|
      m.member_type = @member[:member_type]
      m.account_name = @member[:account_name]
      m.email =  @member[:email]
      m.new_password = @member[:password]
      m.title = @member[:title]
      m.first_name = @member[:first_name]
      m.last_name = @member[:last_name]
      m.birth_date = @member[:birth_date]
      m.details = @member[:details]
      m.referrer = @member[:referrer]
      m.newsletter = @member[:newsletter]
      m.promotion = @member[:newsletter]
      m.language = @member[:locale]
    end

    if member.save
      MemberMailer.email_confirmation(member).deliver_later(wait: 20.seconds)
      # MemberMailer.email_confirmation(member, request.base_url).deliver_later
      # MailerJob.set(wait: 5.seconds).perform_later(member)

      response_success({ :member => member })
      return
    end

    response_validation_errors(member.errors.messages)
  end

  def import
    begin
      response_success({ :data => Member.import(params[:file]) })
    rescue => error
      # response_error_body(error.message, 400)
      response_error_by_code(400)
    end
  end

  def profile
    response_success({ :member => session[:member] })
  end

  def update
  end

  def recover_password
    begin
      @member = params[:member]

      member = Member.find_by_email(@member[:email])

      if member.nil?
        response_error_by_code(404)
        return
      end

      member.recovery_uid = SecureRandom.hex
      member.recovery_at = Time.now + 30.minutes
      
      if member.save
        MemberMailer.recovery_instructions(member).deliver_later(wait: 20.seconds)
      end

      response_success({ :member => member.slice(:email, :first_name, :last_name) })

    rescue => error
      # response_error_body(error.message, 400)
      response_error_by_code(400)
    end
  end

  def reset_password
    begin
      @member = params[:member]

      member = Member.recover_password(@member[:email], @member[:uid])

      # Check if request exist
      if member.nil?
        response_error_by_code(404)
        return
      end

      # Check expiration
      if member.recovery_at < Time.now.utc
          response_error_by_code(419)
          return
      end
  
      is_updated = false

      if request.post?
        member.new_password = @member[:new_password]
        member.recovery_uid = ""
        member.recovery_at = nil

        if member.save
          is_updated = true
        end
      end

      response_success({ :updated => is_updated, :member => member.slice(:email, :first_name, :last_name, :recovery_at) })

    rescue => error
      response_error_by_code(400)
    end
  end

end
