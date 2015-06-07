class UpdateArticleColumn < ActiveRecord::Migration
  def change
  	rename_column :articles, :user_id, :created_by
  end
end
