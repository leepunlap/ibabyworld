class Member < ActiveRecord::Base

  has_one :member_details
  has_one :member_referrer

  include Extensions

  exclude_columns = [:password]

  attr_accessor :details, :referrer, :new_password

  validates_presence_of :account_name, :email, :first_name, :last_name, :message => "Bad request"
  validates_presence_of :new_password, :message => "Bad request", on: :create
  validates_uniqueness_of :email, :message => "Conflict found"
  validates_confirmation_of :new_password, :if => :password_changed?
	
  before_save :hash_new_password, :if => :password_changed?
  before_save :check_empty_fields

  after_create :create_member_detail
  after_create :create_member_referrer

  def password_changed?
    !@new_password.blank?
  end

  def hash_new_password
    if !@new_password.nil?
      self.password = BCrypt::Password.create(@new_password)
    end
  end

  def check_empty_fields
    self.title = self.title == nil ? 0 : self.title
    self.member_type = self.member_type == nil ? 0 : self.member_type
    self.newsletter = self.newsletter == nil ? 0 : self.newsletter
    self.promotion = self.promotion == nil ? 0 : self.promotion
    self.language = self.language == nil ? "en_US" : self.language

    self.gender = self.title == 0 ? 0 : 1 

    self.first_name = self.first_name.titleize
    self.last_name = self.last_name.titleize
  end
  
  # Exclude password info from json output.
  # def to_json(options={})
  #   options[:except] ||= [:password]
  #   super(options)
  # end

  def create_member_detail
      if @details != nil
      member_detail = MemberDetail.new do |d|
        d.member_id = self.id
        d.details = @details
      end

      member_detail.save
    end
  end

  def create_member_referrer
    if self.member_type > 0
       member_referrer = MemberReferrer.new do |r|
         r.member_id = self.id
         r.invitation_code = @referrer[:code]
         r.email = @referrer[:email]
       end

       member_referrer.save
    end
  end

  # Request
  def self.authenticate(email, password)
    if member = find_by_email(email)
      if BCrypt::Password.new(member.password).is_password? password
        return member
      end
    end
      
    return nil
  end

  def self.recover_password(email, uid)
    members = Member.where(:email => email, :recovery_uid => uid).limit(1)

    if members.empty?
      return nil
    end

    return members[0]
  end

  def self.import(file)
    xlsx  = Roo::Spreadsheet.open(file.path)
    index = 0
    success = 0
    errors = 0
    existing = 0 

     xlsx.each_row_streaming do |row|
      # break if index > 20

      # Skip the first two rows
      if index > 1
        # Check account_name, email, first_name and last_name if nil
        if row[3].present? && row[8].present? && row[4].present? && row[5].present?
            if find_by_email(row[8].value) != nil
              existing += 1
              next
            end
            
            member = Member.create do |m|
              m.member_type = 0
              m.account_name = row[3].value
              m.email = row[8].value
              m.first_name = row[5].value
              m.last_name = row[4].value
              m.birth_date = (row[7].value != nil ? DateTime.parse(row[7].value) : nil)
              m.new_password = BCrypt::Password.create(SecureRandom.hex)
              m.title = row[6].value == "F" ? 1 : 0
              m.newsletter = 0
              m.promotion = 0
              m.recovery_uid = SecureRandom.hex
              m.recovery_at = Time.now + 30.day
              # m.details = ActionController::Parameters.new({
              #   'childs' => {
              #     'total' => 0
              #   }
              #   'contact_numbers' => [{
              #     'mobile' => row[9].value
              #   }]
              # })
            end

            if member.save
              MemberMailer.import_member_confirmation(member).deliver_later(wait: 20.seconds)

              success += 1
              index += 1
            end
        end

        errors += 1
      end

      index += 1
    end

    return {
      'success' => success, 
      'errors' => errors,
      'existing' => existing
    }
  end

end
