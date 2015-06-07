class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :oauth_uid, limit: 25
      t.string :account_name, limit: 25
      t.string :email, limit: 50
      t.string :password, limit: 60
      t.integer :title, limit: 1
      t.integer :gender, limit: 1
      t.string :first_name, limit: 25
      t.string :last_name, limit: 25
      t.date :birth_date
      t.integer :member_type, limit: 1
      t.string :language, limit: 10
      t.integer :newsletter, limit: 1
      t.integer :promotion, limit: 1

      t.timestamps null: false
    end
  end
end
