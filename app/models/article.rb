class Article < ActiveRecord::Base
  has_many :article_images
  acts_as_taggable

  include GlobalHelper

  attr_accessor :file

  validates_presence_of :title, :description, :content, :message => "Bad request"

  before_create :upload_attachment
  before_update :upload_attachment
  before_save :create_slug

  def create_slug
  	self.slug = self.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def upload_attachment
    if @file != nil
		basename = SecureRandom.hex
		basename += ".png"

    	# create the file path
    	path = File.join(@@dir_articles, basename)

    	# write the file
    	File.open(path, "wb") { |f| f.write(@file.read) }

		self.poster = basename;
    end
  end

end
