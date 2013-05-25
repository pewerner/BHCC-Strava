class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.integer :ride_id
      t.integer :rider_id
      t.string :rider_name
      t.float :moving_time
      t.float :elevation_gain
      t.float :distance

      t.timestamps
    end
  end
end
