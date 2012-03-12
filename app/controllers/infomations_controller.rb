class InfomationsController < ApplicationController
  # GET /infomations
  # GET /infomations.json
  def index
    respond_to do |format|
        format.js
    end
   
  end

  # GET /infomations/1
  # GET /infomations/1.json
  def show
    @infomation = Infomation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @infomation }
    end
  end

  # GET /infomations/new
  # GET /infomations/new.json
  def new
    @infomation = Infomation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @infomation }
    end
  end

  # GET /infomations/1/edit
  def edit
    @infomation = Infomation.find(params[:id])
    respond_to do |format|
        format.html #edit.html.erb
        format.json { render :json  => @infomation.to_ext_json  , :success => true }
    end
  end

  # POST /infomations
  # POST /infomations.json
  def create
    @infomation = Infomation.new(params[:infomation])

    respond_to do |format|
      if @infomation.save
        format.html { redirect_to @infomation, :notice => 'Infomation was successfully created.' }
        format.json { render :json => @infomation, :status => :created, :location => @infomation }
      else
        format.html { render :action => "new" }
        format.json { render :json => @infomation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /infomations/1
  # PUT /infomations/1.json
  def update
    @infomation = Infomation.find(params[:id])

    respond_to do |format|
      if @infomation.update_attributes(params[:infomation])
        format.html { redirect_to @infomation, :notice => 'Infomation was successfully updated.' }
        #format.json { head :ok }
	format.json {render :json => {:data => @infomation ,  :success  => true } }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @infomation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /infomations/1
  # DELETE /infomations/1.json
  def destroy
    @infomation = Infomation.find(params[:id])
    @infomation.destroy

    respond_to do |format|
      format.html { redirect_to infomations_url }
      format.json { head :ok }
    end
  end
end
