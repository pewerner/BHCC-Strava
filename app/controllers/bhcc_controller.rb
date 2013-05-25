class BhccController < ApplicationController


def welcome
end
	
	def home


	  	riderData = []
		clubMemberArray = []
		#clubtest = []

		clubMemberArray = getClubMembers("678")

		mileage = []
		eleavation = []
		hours = []
	


		clubMemberArray.each do |member|

			memberId = member["MemberID"]
			riderName = member["MemberName"]

			rideIds = getMemberRides(memberId, '2013-05-01','2013-05-31' )

			riderData.push(getRideData(rideIds, riderName, memberId))

		end



	# store the rider tdata in a global array that can be accessed by the view
	@globalRiderData = riderData



 end



 	# gets all members of the club name and id and return an array of hashes
	

	def getClubMembers(club_id)

		clubMemberArray = []

		url = "http://www.strava.com/api/v1/clubs/#{club_id}/members"

		response = HTTParty.get url,:format  =>"json"

		clubMemberData = JSON.parse(response)

		clubMemberData["members"].each do |member|

		clubMemberArray.push({"MemberID" => member["id"], "MemberName" =>member["name"]})


		end



		return clubMemberArray


	end

	# get the rides of the member with current ID

	def getMemberRides(member_id, startDate, endDate)

	

		url = "http://app.strava.com/api/v1/rides?athleteId=#{member_id}&startDate=#{startDate}&endData=#{endDate}"
	
		rideIds = []

		response = HTTParty.get url,:format  =>"json"
		
		ridedata = JSON.parse(response)
		
		ridedata["rides"].each do |ride|

			rideIds.push(ride["id"])
		end

		return rideIds


	end

	# Takes an array of ride ids and requests all ride informtion
	def getRideData(ride_ids, rider_name, rider_id)

		moving_time = 0;
		elevation_gain = 0
		distance = 0






		ride_ids.each do |ride|


			# check if ride already exists in Database if not request ride info


			if !Rides.exists?(:ride_id => ride)

				puts "Adding Ride to model"
				url = "http://www.strava.com/api/v2/rides/#{ride}"
						
				response = HTTParty.get url,:format  =>"json"
						
				ridedata = JSON.parse(response)
						
				moving_time = moving_time + Integer(ridedata["ride"]["moving_time"])
						
				elevation_gain =  elevation_gain + Integer(ridedata["ride"]["elevation_gain"])

				distance = distance + Integer(ridedata["ride"]["distance"])
			
			# add rides to the model
				rides =Rides.new do |r|

					r.ride_id = ride
					r.rider_id = rider_id
					r.distance = distance
					r.rider_name = rider_name
					r.moving_time = moving_time
					r.elevation_gain = elevation_gain

				end

				rides.save
			else
				
				  	r = Rides.find(:first, :conditions => [ "ride_id = ?", ride])
					
					moving_time = r.moving_time
					elevation_gain = r.elevation_gain
					distance = r.distance


			end


		


		end

	moving_time = (moving_time/3600.0).round(1)
	elevation_gain = (elevation_gain * 3.28084).round(1)
	distance = (distance * 0.000621371).round(1)


	riderData = { "name" => rider_name, "hours" => moving_time,"Elevation" => elevation_gain, "Distance" => distance }

	return riderData

	end

end
