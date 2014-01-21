class TestAppController < ApplicationController


def testhome

puts "hello from home"

@messagetoView = "Here is My Message"

@myParams = params[:code] 

@response = HTTParty.post("https://www.strava.com/oauth/token",
    :query => { :client_id => "177", :client_secret=> "ef771e84b333761f8cdf75b70be82aa396862e5e",:code => params[:code] })




end




end
