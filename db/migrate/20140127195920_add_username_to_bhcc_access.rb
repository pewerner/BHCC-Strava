class AddUsernameToBhccAccess < ActiveRecord::Migration
  def change
    add_column :bhcc_accesses, :userid, :string
  end
end
