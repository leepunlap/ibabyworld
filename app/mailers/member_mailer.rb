class MemberMailer < ApplicationMailer

  default from: "noreply@ibabyworld.com"

  @host_url = ENV['HOST_URL']

  def email_confirmation(member)
    @app_name = ENV['APP_NAME']
    @member = member

    # mail(to: @member[:email], subject: 'Registered Successfully')
    mail(to: @member[:email], subject: 'Registered Successfully')
  end

  def import_member_confirmation(member)
    @recovery_url = ENV['URL_PW_RESET'] +"?uid="+ member[:recovery_uid] +"&email="+ member[:email]
    @app_name = ENV['APP_NAME']
    @member = member

    # mail(to: @member[:email], subject: 'Registered Successfully')
    mail(to: @member[:email], subject: 'Welcome to '+ @app_name)
  end

  def recovery_instructions(member)
    @recovery_url = ENV['URL_PW_RESET'] +"?uid="+ member[:recovery_uid] +"&email="+ member[:email]
    @app_name = ENV['APP_NAME']
    @member = member

    mail(to: @member[:email], subject: @app_name +' 密码恢复') #' Password Recovery'
  end

end
