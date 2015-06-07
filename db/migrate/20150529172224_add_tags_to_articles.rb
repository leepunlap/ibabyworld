class AddTagsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :tags, :text, :after => :title
    rename_column :articles, :permalink, :slug
  end
end
