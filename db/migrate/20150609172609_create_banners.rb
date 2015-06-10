class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.attachment :image
      t.integer :order
      t.text :url
      t.text :description
      t.string :name
      t.string :locale

      t.timestamps null: false
    end
  end
end
