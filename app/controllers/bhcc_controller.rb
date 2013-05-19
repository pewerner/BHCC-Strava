class BhccController < ApplicationController


def welcome
end
	
	def home



	  	riderData = []
		clubMemberArray = []
		clubtest = []
		

	url = 'http://www.strava.com/api/v1/clubs/678/members'

	response = HTTParty.get url,:format  =>"json"

	clubMemberData = JSON.parse(response)

	clubMemberData["members"].each do |member|

	clubMemberArray.push({"MemberID" => member["id"], "MemberName" =>member["name"]})

	
	end



	mileage = []
	eleavation = []
	hours = []
	


	clubMemberArray.each do |member|

	memberId = member["MemberID"]
	riderName = member["MemberName"]

	url = "http://app.strava.com/api/v1/rides?athleteId=#{memberId}&startDate=2013-05-01"
	
	rideIds = []

	response = HTTParty.get url,:format  =>"json"
	ridedata = JSON.parse(response)


	
	ridedata["rides"].each do |ride|

		
		rideIds.push(ride["id"])

	end

	moving_time = 0;
	elevation_gain = 0
	distance = 0

	rideIds.each do |ride|

		url = "http://www.strava.com/api/v2/rides/#{ride}"
		response = HTTParty.get url,:format  =>"json"
		ridedata = JSON.parse(response)
		
		moving_time = moving_time + Integer(ridedata["ride"]["moving_time"])
		
		elevation_gain =  elevation_gain + Integer(ridedata["ride"]["elevation_gain"])

		distance = distance + Integer(ridedata["ride"]["distance"])


	end

	moving_time = (moving_time/3600.0).round(1)
	elevation_gain = (elevation_gain * 3.28084).round(1)
	distance = (distance * 0.000621371).round(1)
	#puts "Rider: #{riderName} Moving Time: #{moving_time} Elevation Gain: #{elevation_gain} Distance: #{distance}"

	riderData.push({ "name" => riderName, "hours" => moving_time,"Elevation" => elevation_gain, "Distance" => distance })

	

end

	#puts riderData

	#puts riderData
	@globalRiderData = riderData
  	   end
end
