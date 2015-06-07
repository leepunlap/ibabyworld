class AddOauthProvideToMembers < ActiveRecord::Migration
  def change
    add_column :members, :oauth_provider, :string, limit: 25
    change_column :members, :account_name, :string, :limit => 60	
    change_column :members, :language, :string, :limit => 10	
  end
end
