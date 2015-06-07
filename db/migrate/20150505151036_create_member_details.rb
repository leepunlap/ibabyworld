class CreateMemberDetails < ActiveRecord::Migration
  def change
    create_table :member_details do |t|
      t.integer :member_id
      t.float :income
      t.integer :childs, limit: 2
      t.text :child_details
      t.string :contact, limit: 50
      t.text :address
    end
  end
end
