class BhccController < ApplicationController
include BhccHelper

def welcome
end
	
	def home


	  	riderData = []
		clubMemberArray = []
		#clubtest = []

		#clubMemberArray = getClubMembers("678")

		mileage = []
		eleavation = []
		hours = []
	


		clubMemberArray.each do |member|

			memberId = member["MemberID"]
			riderName = member["MemberName"]

			#rideIds = getMemberRides(memberId, '2013-07-01','2013-07-31' )

			#riderData.push(getRideData(rideIds, riderName, memberId))
			riderData.push(getRideData())

		end



	# store the rider tdata in a global array that can be accessed by the view
	@globalRiderData = riderData



 end

def leaderboard
		@token = at()
		@accessRoad = leaderBoard("this_year", "574991", "678")
		@barnburner = leaderBoard("this_year", "4041153", "678")




end






 	# gets all members of the club name and id and return an array of hashes
	

	def getClubMembers(club_id)

		clubMemberArray = []

		# This URL is from the old API
		#url = "http://www.strava.com/api/v1/clubs/#{club_id}/members"

		#This is URL is the new one
		url = "https://www.strava.com/api/v3/clubs/678/activities?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce"


		response = HTTParty.get url,:format  =>"json"

		clubMemberData = JSON.parse(response)

		clubMemberData["members"].each do |member|

		clubMemberArray.push({"MemberID" => member["id"], "MemberName" =>member["name"]})


		end



		return clubMemberArray


	end

	# get the rides of the member with current ID

	def getMemberRides(member_id, startDate, endDate)

	#"http://app.strava.com/api/v1/rides?athleteId=1824936&startDate=2013-05-01&endData=2013-05-31

		#url = "http://app.strava.com/api/v1/rides?athleteId=#{member_id}&startDate=#{startDate}&endData=#{endDate}"
	
		url ="https://www.strava.com/api/v3/#{member_id}/activities"
		rideIds = []

		response = HTTParty.get url,:format  =>"json"
		
		ridedata = JSON.parse(response)
		
		ridedata["rides"].each do |ride|
			puts "hello"	
			rideIds.push(ride["id"])
			puts ride["id"]
			

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
					r.distance = Integer(ridedata["ride"]["distance"])
					r.rider_name = rider_name
					r.moving_time = Integer(ridedata["ride"]["moving_time"])
					r.elevation_gain = Integer(ridedata["ride"]["elevation_gain"])

				end

				rides.save
			
			# if the Ride alredy exists look it up in the Database instead of sending a web request	
			else
				

				  	r = Rides.find(:first, :conditions => [ "ride_id = ?", ride])
					
					moving_time = moving_time + r.moving_time 
					elevation_gain = elevation_gain + r.elevation_gain
					distance = distance +  r.distance

					

					

			end


		#Rides.where(["rider_id =?", 2174381]).select("ride_id")


		end

	moving_time = (moving_time/3600.0).round(1)
	elevation_gain = (elevation_gain * 3.28084).round(1)
	distance = (distance * 0.000621371).round(1)
	
	#require 'debugger'; debugger



	riderData = { "name" => rider_name, "hours" => moving_time,"Elevation" => elevation_gain, "Distance" => distance }

	return riderData

	end

	def getLastRide
		puts "Getting last Ride"


		respond_to do |format|

			format.js
			format.json
		end

	end

end
