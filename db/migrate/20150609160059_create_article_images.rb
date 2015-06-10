class CreateArticleImages < ActiveRecord::Migration
  def change
    create_table :article_images do |t|
      t.integer :article_id
      t.attachment :image
      t.boolean :isCover

      t.timestamps null: false
    end
  end
end
