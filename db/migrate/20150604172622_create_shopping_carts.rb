class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.integer :member_id
      t.text :cookies
      t.float :total
      t.integer :status

      t.timestamps null: false
    end
  end
end
