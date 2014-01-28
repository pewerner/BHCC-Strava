class CreateRideData < ActiveRecord::Migration
  def change
    create_table :ride_data do |t|
      t.string :ride_id
      t.integer :athlete_id
      t.float :distance
      t.float :moving_time
      t.float :total_elevation_gain
      t.string :start_date
      t.string :location_city
      t.string :trainer
      t.float :average_speed
      t.float :max_speed
      t.float :calories
      t.float :total_work
      t.float :max_power
      t.float :avg_power

      t.timestamps
    end
  end
end
