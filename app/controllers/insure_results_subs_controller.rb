class InsureResultsSubsController < ApplicationController
  # GET /insure_results_subs
  # GET /insure_results_subs.json
  def index
    @insure_results_subs = InsureResultsSub.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @insure_results_subs }
    end
  end
  
  def grid
    @insureResultsSub = InsureResultsSub.where(:main_id => params[:main_id])
    respond_to do |format|
        format.json { render :json => {:success => true , :data => @insureResultsSub , :total => @insureResultsSub.size} }
    end
  end

  # GET /insure_results_subs/1
  # GET /insure_results_subs/1.json
  def show
    @insure_results_sub = InsureResultsSub.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @insure_results_sub }
    end
  end

  # GET /insure_results_subs/new
  # GET /insure_results_subs/new.json
  def new
    @insure_results_sub = InsureResultsSub.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @insure_results_sub }
    end
  end

  # GET /insure_results_subs/1/edit
  def edit
    @insure_results_sub = InsureResultsSub.find(params[:id])
  end

  # POST /insure_results_subs
  # POST /insure_results_subs.json
  def create
    @insure_results_sub = InsureResultsSub.new(params[:insure_results_sub])

    respond_to do |format|
      if @insure_results_sub.save
        format.html { redirect_to @insure_results_sub, :notice => 'Insure results sub was successfully created.' }
        format.json { render :json => @insure_results_sub, :status => :created, :location => @insure_results_sub }
      else
        format.html { render :action => "new" }
        format.json { render :json => @insure_results_sub.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /insure_results_subs/1
  # PUT /insure_results_subs/1.json
  def update
    @insure_results_sub = InsureResultsSub.find(params[:id])

    respond_to do |format|
      if @insure_results_sub.update_attributes(params[:insure_results_sub])
        format.html { redirect_to @insure_results_sub, :notice => 'Insure results sub was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @insure_results_sub.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /insure_results_subs/1
  # DELETE /insure_results_subs/1.json
  def destroy
    @insure_results_sub = InsureResultsSub.find(params[:id])
    @insure_results_sub.destroy

    respond_to do |format|
      format.html { redirect_to insure_results_subs_url }
      format.json { head :ok }
    end
  end
end
