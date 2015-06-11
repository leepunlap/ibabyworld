class RenameColCoupon < ActiveRecord::Migration
  def change
    rename_column :coupons, :desciption_en_US, :description_en_US
  end
end
