class ChangeLanguageCol < ActiveRecord::Migration
  def change
	change_column :members, :language, :string, :limit => 10
  end
end
