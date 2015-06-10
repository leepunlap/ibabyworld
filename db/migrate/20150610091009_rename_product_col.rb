class RenameProductCol < ActiveRecord::Migration
  def change
    rename_column :products, :desciption_en_US, :description_en_US
  end
end
