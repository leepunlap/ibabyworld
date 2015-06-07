class MailerJob < ActiveJob::Base
  queue_as :urgent

  def perform(member)
    
  end
end
