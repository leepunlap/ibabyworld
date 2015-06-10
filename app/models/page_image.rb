class PageImage < ActiveRecord::Base
  belongs_to :page

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "120x120>" }, :default_url => "/default.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def image_url_medium
    image.url(:medium)
  end
end
