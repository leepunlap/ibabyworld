class CreateShoppingCartItems < ActiveRecord::Migration
  def change
    create_table :shopping_cart_items do |t|
      t.integer :product_id
      t.float :unit_price
      t.integer :qty
      t.integer :shopping_cart_id
      t.integer :coupon_id
      t.float :sub_total

      t.timestamps null: false
    end
  end
end
