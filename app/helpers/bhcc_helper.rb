module BhccHelper

	require 'json'
	






	def at

		
			return "ed8f4919f42c9d737cf4a314b7867cd7cddc55ce"
	end


 		
	def leaderBoard(dateRange, sementID, clubID)

		
			# Blue HIll

		#pete = "https://www.strava.com/api/v3/1824936/activities?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce"
		#url="https://www.strava.com/api/v3/clubs/678/activities?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&per_page=#{perpage}&page=#{page}"

		#url="https://www.strava.com/api/v3/segments/574991/leaderboard?access_token=ed8f4919f42c9d737cf4a314b7867cd7cddc55ce&club_id=678"
		url="https://www.strava.com/api/v3/segments/#{sementID}/leaderboard?access_token=#{at()}&club_id=#{clubID}&date_range=#{dateRange}&per_page=15"

		response = HTTParty.get url,:format  =>"json"

		ridedata = JSON.parse(response)

		ridedata["entries"].each do |ride|

			
			rank = ride["rank"]

			athlete_name = ride["athlete_name"]

			elapsed_time = ride["elapsed_time"]

			date = ride["start_date_local"]

			profile =ride["athlete_profile"]

			puts "Rank: #{rank} Name #{athlete_name} Time: #{elapsed_time}  date #{date} Profile #{ride["athlete_profile"]} "


		end

		return ridedata["entries"]	



	end




end
