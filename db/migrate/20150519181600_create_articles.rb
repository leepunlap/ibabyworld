class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, limit: 150
      t.text :content
      t.string :banner_url, limit: 70
      t.integer :status, limit: 1
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
