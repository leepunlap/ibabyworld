class Banner < ActiveRecord::Base
  acts_as_taggable
  
  has_attached_file :image, :styles => { :medium => "1032×345>", :thumb => "103x34>" }, :default_url => "/default.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	def image_url_medium
		image.url(:medium)
	end
end
