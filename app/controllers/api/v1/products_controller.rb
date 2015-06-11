class Api::V1::ProductsController < ApplicationController

  # Removing this line causes 422 "Unprocessable Entity Error"
  # It happens if we call the api request below without refreshing the page
  skip_before_action :verify_authenticity_token

  def index
    @product = Product.all
    render json: @product.to_json(include: [:tags])
  end

  def create
    @product = Product.new(post_params)

    @product.tag_list = params[:tags].map{|t| t[:name]}
    @product.save

    render json: @product
  end

  def show
    @product = Product.find(params[:id])
    render json: @product.to_json(include: [:tags])
  end

  def update
    @product = Product.find(params[:id])

    @product.tag_list = params[:tags].map{|t| t[:name]}
    @product.update_attributes!(post_params)

    render json: @product
  end

  def destroy
    @product = Product.find(params[:id])

    @product.destroy

    response_success({})
  end

  def get_medium_images
    @a = Product.find(params[:product_id])
    render json: @a.product_images.to_json(methods: [:cover_url_medium])
  end

  private
  def post_params
    params.require(:product).permit(:sku, :status, :tags, :discounted_price, :discount_description_en_US, :discount_description_zh_CN, :discount_description_zh_HK, :description_en_US, :description_zh_CN, :description_zh_HK, :name_en_US, :name_zh_HK, :name_zh_CN, :brand_id, :short_description_en_US, :short_description_zh_CN, :short_description_zh_HK, :unit_price)
  end


  # def get_tag_list
  #   @tags = ActsAsTaggableOn::Tagging.includes(:tag).where(taggable_type: 'Product').map { |tagging| { 'id' => tagging.tag_id.to_s, 'name' => tagging.tag.name } }.uniq
  #   response_success({ :tags => @tags })
  # end
  #
  # def create
  #   begin
  #     # Product status (0 = draft, 1 = review, 2 = publish, 3 = hidden)
  #     product = Product.create do |a|
  #       a.sku = params[:sku]
  #       a.description_en_US = params[:description_en_US]
  #       a.description_zh_CN = params[:description_zh_CN]
  #       a.description_zh_HK = params[:description_zh_HK]
  #       a.name_en_US = params[:name_en_US]
  #       a.name_zh_HK = params[:name_zh_HK]
  #       a.name_zh_CN = params[:name_zh_CN]
  #       a.brand_id = params[:brand_id]
  #       a.short_description_en_US = params[:short_description_en_US]
  #       a.short_description_zh_CN = params[:short_description_zh_CN]
  #       a.short_description_zh_HK = params[:short_description_zh_HK]
  #       a.unit_price = params[:unit_price]
  #       a.discounted_price = params[:discounted_price]
  #       a.discount_description_en_US = params[:discount_description_en_US]
  #       a.discount_description_zh_CN = params[:discount_description_zh_CN]
  #       a.discount_description_zh_HK = params[:discount_description_zh_HK]
  #       #a.tags = tags_only(params[:tags])
  #       a.tag_list = params[:tags]
  #       a.status =  params[:status]
  #     end
  #
  #     product.save
  #
  #     if product.errors.any? == true
  #       response_validation_errors(product.errors.messages)
  #       return;
  #     end
  #
  #     response_success({ :product => product })
  #
  #   rescue => error
  #     response_error_body(error.message, 400)
  #   end
  # end
  #
  # def update
  #   begin
  #     product = Product.find_by_id(params[:id]);
  #
  #     if product == nil
  #       response_error_by_code(404)
  #       return
  #     end
  #
  #
  #     # if !params[:file].nil?
  #     #   product.file = params[:file]
  #     # end
  #
  #     # if product.status != 2
  #     #   product.published_by = params[:status] == "0" ? nil : 0
  #     # end
  #
  #     product.sku = params[:sku]
  #     product.desciption_en_US = params[:desciption_en_US]
  #     product.description_zh_CN = params[:description_zh_CN]
  #     product.description_zh_HK = params[:description_zh_HK]
  #     product.name_en_US = params[:name_en_US]
  #     product.name_zh_HK = params[:name_zh_HK]
  #     product.name_zh_CN = params[:name_zh_CN]
  #     product.brand_id = params[:brand_id]
  #     product.short_description_en_US = params[:short_description_en_US]
  #     product.short_description_zh_CN = params[:short_description_zh_CN]
  #     product.short_description_zh_HK = params[:short_description_zh_HK]
  #     product.unit_price = params[:unit_price]
  #     product.discounted_price = params[:discounted_price]
  #     product.discount_description_en_US = params[:discount_description_en_US]
  #     product.discount_description_zh_CN = params[:discount_description_zh_CN]
  #     product.discount_description_zh_HK = params[:discount_description_zh_HK]
  #     #product.tags = tags_only(params[:tags])
  #     product.tag_list = params[:tags]
  #     product.status =  params[:status]
  #
  #
  #     # product.update_attributes()
  #
  #
  #     product.save
  #
  #     response_success({ :product => product })
  #
  #   rescue => error
  #     response_error_body(error.message, 400)
  #   end
  # end
  #
  # def delete
  #   product = Product.find_by_id(params[:id]);
  #
  #   if product == nil
  #     response_error_by_code(404)
  #     return
  #   end
  #
  #   product.delete
  #
  #   response_success({ :product => product })
  # end
  #
  # def product_image_upload
  #   @productImage = ProductImage.new
  #
  #
  #   @productImage.save
  #
  #   response_success({ :product_image => @productImage })
  # end
end
