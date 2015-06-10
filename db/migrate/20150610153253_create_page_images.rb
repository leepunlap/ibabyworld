class CreatePageImages < ActiveRecord::Migration
  def change
    create_table :page_images do |t|
      t.integer :page_id
      t.attachment :image
      t.boolean :isCover

      t.timestamps null: false
    end
  end
end
