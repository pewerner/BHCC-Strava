class AddUsernamessToBhccAccesses < ActiveRecord::Migration
  def change
  	add_column :bhcc_accesses, :username, :string
  end
end
