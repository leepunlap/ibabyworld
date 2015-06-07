class AddRecoveryFieldAtMember < ActiveRecord::Migration
  
  def change
  	add_column :members, :recovery_uid, :string, limit: 65, :after => :promotion
    add_column :members, :recovery_at, :datetime, :after => :recovery_uid
  end

end
