class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :sku
      t.text :description_en_US
      t.text :description_zh_CN
      t.text :description_zh_HK
      t.string :name_en_US
      t.string :name_zh_CN
      t.string :name_zh_HK
      t.integer :brand_id
      t.text :short_description_en_US
      t.text :short_description_zh_CN
      t.text :short_description_zh_HK
      t.float :unit_price
      t.float :discounted_price
      t.string :discount_description_en_US
      t.string :discount_description_zh_CN
      t.string :discount_description_zh_HK
      t.integer :status

      t.timestamps null: false
    end
  end
end
