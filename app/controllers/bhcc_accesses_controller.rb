class BhccAccessesController < ApplicationController
  # GET /bhcc_accesses
  # GET /bhcc_accesses.json
  def index

    
    

    online_mode = 0



    myParams = params[:code] 

    #response = HTTParty.post("https://www.strava.com/oauth/token",
      #:query => { :client_id => "177", :client_secret=> "ef771e84b333761f8cdf75b70be82aa396862e5e",:code => params[:code] })

    

    access_token = 'ed8f4919f42c9d737cf4a314b7867cd7cddc55ce'
    
    



    #access_token = response["access_token"]

   if BhccAccess.exists?(:token => access_token)

      puts "This token is already registered"

    else
    
    url = "https://www.strava.com/api/v3/athlete?access_token=#{access_token}"
    user_response = HTTParty.get url,:format  =>"json"

    user = JSON.parse(user_response)

    firstname = user["firstname"]
    lastname = user["lastname"]
    fullname = "#{firstname} #{lastname}"
    athlete_id = user["id"]


    # add access token to database
    token =BhccAccess.new do |t|

          t.token = access_token
          t.username = fullname
          t.userid = athlete_id

        end

        token.save
    
   end

    @bhcc_accesses = BhccAccess.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bhcc_accesses }
    end
  end

  # GET /bhcc_accesses/1
  # GET /bhcc_accesses/1.json
  def show
    @bhcc_access = BhccAccess.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bhcc_access }
    end
  end

  # GET /bhcc_accesses/new
  # GET /bhcc_accesses/new.json
  def new
    @bhcc_access = BhccAccess.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bhcc_access }
    end
  end

  # GET /bhcc_accesses/1/edit
  def edit
    @bhcc_access = BhccAccess.find(params[:id])
  end

  # POST /bhcc_accesses
  # POST /bhcc_accesses.json
  def create
    @bhcc_access = BhccAccess.new(params[:bhcc_access])

    respond_to do |format|
      if @bhcc_access.save
        format.html { redirect_to @bhcc_access, notice: 'Bhcc access was successfully created.' }
        format.json { render json: @bhcc_access, status: :created, location: @bhcc_access }
      else
        format.html { render action: "new" }
        format.json { render json: @bhcc_access.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bhcc_accesses/1
  # PUT /bhcc_accesses/1.json
  def update
    @bhcc_access = BhccAccess.find(params[:id])

    respond_to do |format|
      if @bhcc_access.update_attributes(params[:bhcc_access])
        format.html { redirect_to @bhcc_access, notice: 'Bhcc access was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bhcc_access.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bhcc_accesses/1
  # DELETE /bhcc_accesses/1.json
  def destroy
    @bhcc_access = BhccAccess.find(params[:id])
    @bhcc_access.destroy

    respond_to do |format|
      format.html { redirect_to bhcc_accesses_url }
      format.json { head :no_content }
    end
  end
end
