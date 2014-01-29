class BhccController < ApplicationController
include BhccHelper

def welcome
end
	
def home


	riderData = []
	clubMemberArray = []

	mileage = []
	eleavation = []
	hours = []
	
	BhccAccess.destroy(3);
	#get all registerd member ids and user names		
	BhccAccess.find(:all).each  do |member|

		memberId = member.userid
		riderName = member.username

		riderData.push(getRideData(riderName, memberId))

	end

	# store the rider tdata in a global array that can be accessed by the view
	@globalRiderData = riderData



 end

# Takes an array of ride ids and requests all ride informtion
def getRideData(rider_name, rider_id)

		
	moving_time = 0;
	elevation_gain = 0
	distance = 0
	puts "this is the rider_id #{rider_id}"


	ridedata = RideDatum.where(:athlete_id => Integer(rider_id))



	ridedata.each do |r|

		puts "Match"
		moving_time = moving_time + r.moving_time 
		elevation_gain = elevation_gain + r.total_elevation_gain
		distance = distance +  r.distance

	end


	moving_time = (moving_time/3600.0).round(1)
	elevation_gain = (elevation_gain * 3.28084).round(1)
	distance = (distance * 0.000621371).round(1)


	riderData = { "name" => rider_name, "hours" => moving_time,"Elevation" => elevation_gain, "Distance" => distance }

return riderData

end

end
