class Rides < ActiveRecord::Base
  attr_accessible :distance, :elevation_gain, :moving_time, :ride_id, :rider_id, :rider_name
end
