class BhccAccessesController < ApplicationController
  # GET /bhcc_accesses
  # GET /bhcc_accesses.json
  def index
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
