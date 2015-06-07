class AuthMember
  # require 'user_library'

  attr_accessor :id, :token, :account_name, :email, :first_name, :last_name, :language, :country
 
  def initialize(*attributes)
    if attributes.length == 1 && attributes.first.kind_of?(Hash)
      attributes.first.each { |k,v| send("#{k}=",v) }
    end
  end

  def name
    @first_name +" "+ @last_name
  end

  def self.destroy
  	self.token = nil
  end

end