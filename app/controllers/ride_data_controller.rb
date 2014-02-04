class RideDataController < ApplicationController
  # GET /ride_data
  # GET /ride_data.json
  


  def checkifValid(floatTest)

    if(floatTest == nil)
      floatTest = 0.0
    end

    return floatTest

  end


  def index

   

    #get loop through rider credentials data base
    BhccAccess.find(:all).each do |token|

    url = "https://www.strava.com/api/v3/athlete/activities?access_token=#{token.token}"

    response = HTTParty.get url,:format  =>"json"
    
    ridedata = JSON.parse(response)

    ridedata.each do |ride|
    
    puts token.token
 
      if !RideDatum.exists?(:ride_id => String(ride["id"]))
           puts ride["id"]
          rides =RideDatum.new do |r|

            r.athlete_id = Integer(checkifValid(ride["athlete"]["id"]))  
            r.average_speed = Float(checkifValid(ride["average_speed"]))
            r.avg_power = Float(checkifValid(ride["average_power"]))
            r.calories = Float(checkifValid(ride["calories"]))
            r.location_city = ride["location_city"]
            r.max_power = Float(checkifValid(ride["max_power"]))
            r.max_speed = Float(checkifValid(ride["max_speed"]))
            r.moving_time = Float(checkifValid(ride["moving_time"]))
            r.ride_id = String(ride["id"])

        

            r.start_date =  ride["start_date_local"]  
            
            r.total_elevation_gain = ride["total_elevation_gain"]
            r.total_work = Float(checkifValid(ride["kilojoules"]))
            r.trainer = ride["trainer"]
            r.username = token.username
            r.distance = Float(checkifValid(ride["distance"]))
            
        end

        rides.save
      
      end
    end
    end


    @ride_data = RideDatum.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ride_data }
    end
  end

  # GET /ride_data/1
  # GET /ride_data/1.json
  def show
    @ride_datum = RideDatum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ride_datum }
    end
  end

  # GET /ride_data/new
  # GET /ride_data/new.json
  def new
    @ride_datum = RideDatum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ride_datum }
    end
  end

  # GET /ride_data/1/edit
  def edit
    @ride_datum = RideDatum.find(params[:id])
  end

  # POST /ride_data
  # POST /ride_data.json
  def create
    @ride_datum = RideDatum.new(params[:ride_datum])

    respond_to do |format|
      if @ride_datum.save
        format.html { redirect_to @ride_datum, notice: 'Ride datum was successfully created.' }
        format.json { render json: @ride_datum, status: :created, location: @ride_datum }
      else
        format.html { render action: "new" }
        format.json { render json: @ride_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ride_data/1
  # PUT /ride_data/1.json
  def update
    @ride_datum = RideDatum.find(params[:id])

    respond_to do |format|
      if @ride_datum.update_attributes(params[:ride_datum])
        format.html { redirect_to @ride_datum, notice: 'Ride datum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ride_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ride_data/1
  # DELETE /ride_data/1.json
  def destroy
    @ride_datum = RideDatum.find(params[:id])
    @ride_datum.destroy

    respond_to do |format|
      format.html { redirect_to ride_data_url }
      format.json { head :no_content }
    end
  end
end
