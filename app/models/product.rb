class Product < ActiveRecord::Base
	acts_as_taggable
	has_many :product_images
	belongs_to :brand
end
