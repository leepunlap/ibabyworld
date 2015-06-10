class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :browser_title
      t.text :browser_url
      t.string :locale
      t.text :content
      t.integer :status

      t.timestamps null: false
    end
  end
end
