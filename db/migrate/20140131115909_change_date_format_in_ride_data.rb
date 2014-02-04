class ChangeDateFormatInRideData < ActiveRecord::Migration
  def up

  	change_column :ride_data, :start_date, :datetime

  end

  def down
  end
end
