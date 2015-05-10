class AddUsernameToRideDatums < ActiveRecord::Migration
  def change
    add_column :ride_data, :username, :string
  end
end
