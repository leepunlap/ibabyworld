class MemberDetail < ActiveRecord::Base

  belongs_to :member

  attr_accessor :details

  # serialize :child_details, :contact

  before_save :parse_contact_numbers
  before_save :parse_child_details
  before_save :parse_other_details

  def parse_contact_numbers
    if @details.has_key?('contact_numbers')
      contact_numbers = Array.new

      @details[:contact_numbers].delete_if { |key, value| value.strip == '' }
      
      # Parse member contact numbers
      @details[:contact_numbers].each do |device, number|
        contact = Hash.new

        contact[device] = number

        contact_numbers.push({ device => number })
      end

      if contact_numbers.any?
        self.contact = contact_numbers.to_json.to_s
      end
    end
  end

  def parse_child_details
    if @details.has_key?('childs')
      child_details = Array.new

      # Parse member children details
      if @details[:childs].has_key?("age")
        @details[:childs][:age].each do |index, age|
          child = Hash.new
          child['first_name'] = ""
          child['last_name'] = ""
          child['age'] = age

          child_details.push(child)
        end
      end

      if child_details.any?
        self.child_details = child_details.to_json.to_s
      end
    end
  end

  def parse_other_details
    if @details.has_key?('address')
      @details[:address].delete_if { |value| value.strip == '' }
      
      if @details[:address].any?
        self.address = @details[:address].to_json.to_s
      end
    end

    self.childs = @details[:childs][:total]
    self.income = @details[:income]
  end

end
