class AddPaymentToShoppingCart < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :paymentid, :string
    add_column :shopping_carts, :paymenturl, :string
  end
end
