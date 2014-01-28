class RideDatum < ActiveRecord::Base
  attr_accessible :athlete_id, :average_speed, :avg_power, :calories, :distance, :location_city, :max_power, :max_speed, :moving_time, :ride_id, :start_date, :total_elevation_gain, :total_work, :trainer, :username
end
