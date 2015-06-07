class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name_en_US
      t.string :name_zh_CN
      t.string :name_zh_HK
      t.attachment :cover

      t.timestamps null: false
    end
  end
end
