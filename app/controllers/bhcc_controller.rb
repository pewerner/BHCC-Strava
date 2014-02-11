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

	ridedata1 = ridedata.find(:all, :conditions =>["date(start_date) BETWEEN ? AND ? ", '2014-02-01 00:00:00', '2014-02-28:23:59:00'])

	ridedata1.each do |r|

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


def storeData(requestedData, dpv, inputArray)

	    requestedData["entries"].each_with_index do |entries, index|
		
    			if index < 10

    			pointValue = dpv -(index * dpv/10.to_f)

				inputArray.push({ "name" => entries["athlete_name"], "points" =>  pointValue })
				end

		
	    
    end
return inputArray

end

def leaderboard()


	#access road	

	mensData = []
	womensData = []
	dirtData = []


	@accessRoadPointValue = 15
	@hemenwayDataPointValue = 10
	@backsideDataPointValue = 15
	@ricciutiDataPointValue = 10
	@chickatawbutDataPointValue = 15
	@unquityDataPointValue = 10	


	@summitrdDataPointValue = 15
	@gaslineDataPointValue = 15
	@yellowjacketDataPointValue = 15
	@buck_hillDataPointValue = 15
	@catwalkDataPointValue = 15


    url = " https://www.strava.com/api/v3/segments/663022/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @accessRoadData = JSON.parse(user_response)

	mensData = storeData(@accessRoadData, @accessRoadPointValue, mensData)



    url = " https://www.strava.com/api/v3/segments/663022/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&gender=F&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @accessRoadDataFemale = JSON.parse(user_response)
    womensData = storeData(@accessRoadDataFemale, @accessRoadPointValue, womensData)

    url = "https://www.strava.com/api/v3/segments/1297700/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @hemenwayData = JSON.parse(user_response)

    mensData = storeData(@hemenwayData, @hemenwayDataPointValue, mensData)



	#mensData = storeData(@hemenwayData, @hemenwayDataPointValue, mensData)

    url = "https://www.strava.com/api/v3/segments/1297700/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&gender=F&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @hemenwayDataFemale = JSON.parse(user_response)
 	womensData = storeData(@hemenwayDataFemale, @hemenwayDataPointValue, womensData)


    url = "https://www.strava.com/api/v3/segments/1418768/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @backside = JSON.parse(user_response)

    mensData = storeData(@backside, @backsideDataPointValue, mensData)

    url = "https://www.strava.com/api/v3/segments/1418768/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&gender=F&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @backsideFemale = JSON.parse(user_response)
    womensData = storeData(@backsideFemale, @backsideDataPointValue, womensData)

    url = "https://www.strava.com/api/v3/segments/1030272/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @ricciuti = JSON.parse(user_response)

    mensData = storeData(@ricciuti, @ricciutiDataPointValue, mensData)

    url = "https://www.strava.com/api/v3/segments/1030272/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&gender=F&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @ricciutiFemale = JSON.parse(user_response)
    womensData = storeData(@ricciutiFemale, @ricciutiDataPointValue, womensData)

    url = "https://www.strava.com/api/v3/segments/628440/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @chickatawbut  = JSON.parse(user_response)

    mensData = storeData(@chickatawbut, @chickatawbutDataPointValue , mensData)

    url = "https://www.strava.com/api/v3/segments/628440/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&gender=F&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @chickatawbutFemale = JSON.parse(user_response)
    womensData = storeData(@chickatawbutFemale, @chickatawbutDataPointValue, womensData)

    url = "https://www.strava.com/api/v3/segments/630626/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @unquity = JSON.parse(user_response)
    mensData = storeData(@unquity, @unquityDataPointValue, mensData)

    url = "https://www.strava.com/api/v3/segments/630626/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&gender=F&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @unquityFemale = JSON.parse(user_response)
    womensData = storeData(@unquityFemale, @unquityDataPointValue, womensData)


    #dirt Data

    url = "https://www.strava.com/api/v3/segments/1246804/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @summitrd = JSON.parse(user_response)
    dirtData = storeData(@summitrd, @summitrdDataPointValue, dirtData) 

    url = "https://www.strava.com/api/v3/segments/1362469/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @gasline = JSON.parse(user_response)
    dirtData = storeData(@gasline, @gaslineDataPointValue, dirtData)



    url = "https://www.strava.com/api/v3/segments/4508329/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @yellowjacket = JSON.parse(user_response)
    dirtData = storeData(@yellowjacket, @yellowjacketDataPointValue, dirtData)


    url = "https://www.strava.com/api/v3/segments/5599090/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @buck_hill = JSON.parse(user_response)

    dirtData = storeData(@buck_hill, @buck_hillDataPointValue, dirtData)

    url = "https://www.strava.com/api/v3/segments/2954643/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678&date_range=this_year"
    user_response = HTTParty.get url,:format  =>"json"

    @catwalk = JSON.parse(user_response)

    dirtData = storeData(@catwalk, @catwalkDataPointValue, dirtData)  





    @mens_leaders = generateRiderResults(mensData)
    
    @womens_leaders = generateRiderResults(womensData)

    @dirt_leaders = generateRiderResults(dirtData)



    riderData = []
	clubMemberArray = []

	mileage = []
	eleavation = []
	hours = []
	
	
	

	
	#get all registerd member ids and user names		
	BhccAccess.find(:all).each  do |member|

		memberId = member.userid
		riderName = member.username

		riderData.push(getRideData(riderName, memberId))

	end

	# store the rider tdata in a global array that can be accessed by the view
	@globalRiderData = riderData

	date_updated = RideDatum.last()

	puts "date"
	puts date_updated.updated_at 

	@time_updated =  date_updated.updated_at
	puts 	@time_updated.in_time_zone('Eastern Time (US & Canada)')


end


def generateRiderResults(rider_data )

		uniqueNames = []
		leaderData = []	

		rider_data.each do |md|

	        uniqueNames.push(md["name"])

		end
		
		uniqueNames = uniqueNames.uniq

		uniqueNames.each do |umn|
			
		    total_points = 0.0	
			
			rider_data.each do |md|

			    if (md["name"] == umn)
					
			    total_points = total_points + md["points"].to_f

			    end
			 
		end
 				leaderData.push({"name" => umn, "points" => total_points})
		end	

				leaderData = leaderData.sort { |x, y| y["points"] <=> x["points"] }

			puts leaderData
			return leaderData

end



end
