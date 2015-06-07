class CreateMemberReferrers < ActiveRecord::Migration
  def change
    create_table :member_referrers do |t|
      t.integer :member_id
      t.string :invitation_code, limit: 25
      t.string :email, limit: 50

      t.timestamps null: false
    end
  end
end
