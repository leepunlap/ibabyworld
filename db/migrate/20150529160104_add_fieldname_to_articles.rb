class AddFieldnameToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :description, :string, limit: 150, :after => :title
    add_column :articles, :published_by, :integer, :after => :created_by
    add_column :articles, :permalink, :text, :after => :banner_url
    add_column :articles, :language, :string, limit: 10, :after => :id
    rename_column :articles, :banner_url, :poster
  end
end
