class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :name_en_US
      t.string :name_zh_CN
      t.string :name_zh_HK
      t.attachment :cover
      t.text :desciption_en_US
      t.text :description_zh_CN
      t.text :description_zh_HK

      t.timestamps null: false
    end
  end
end
