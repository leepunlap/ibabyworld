class Coupon < ActiveRecord::Base

  has_attached_file :cover, :styles => { :medium => "300x300>", :thumb => "120x120>" }, :default_url => "/default.png"
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

	def cover_url_medium
		cover.url(:medium)
	end
end
