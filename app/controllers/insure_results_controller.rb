class InsureResultsController < ApplicationController
  include ExtScaffold
  def calcs
      respond_to do |format|
          format.js
      end
  end
  
  def calcs_create
      @calcs = Calcs.new(params[:calcs])
      respond_to  do |format|
          if @calcs.save
              @calcs.calc_insure
              format.html { redirect_to @calcs, :notice => 'Calcs was successfully updated.' }
              format.json { render :json => {:data => @calcs ,  :success  => true } }
          else
            format.html { render :action => "edit" }
            format.json { render :json => @calcs.errors, :status => :unprocessable_entity } 
          end
      end
  end
  
  respond_to do |format|
    if @insure_result.save
      format.html { redirect_to @insure_result, :notice => 'Insure result was successfully created.' }
      format.json { render :json => @insure_result, :status => :created, :location => @insure_result }
    else
      format.html { render :action => "new" }
      format.json { render :json => @insure_result.errors, :status => :unprocessable_entity }
    end
  end
  
  # GET /insure_results
  # GET /insure_results.json
  def index
    respond_to do |format|
       format.js
    end
  end
  
  def grid
    @insureResults = InsureResult.paginate options_from_filter({:data => InsureResult})
    respond_to do |format|
        format.json { render :json => {:success => true , :data => @insureResults , :total => InsureResult.count(options_from_filter())} }
    end
  end

  # GET /insure_results/1
  # GET /insure_results/1.json
  def show
    @insure_result = InsureResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @insure_result }
    end
  end

  # GET /insure_results/new
  # GET /insure_results/new.json
  def new
    @insure_result = InsureResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @insure_result }
    end
  end

  # GET /insure_results/1/edit
  def edit
    @insure_result = InsureResult.find(params[:id])
  end

  # POST /insure_results
  # POST /insure_results.json
  def create
    @insure_result = InsureResult.new(params[:insure_result])

    respond_to do |format|
      if @insure_result.save
        format.html { redirect_to @insure_result, :notice => 'Insure result was successfully created.' }
        format.json { render :json => @insure_result, :status => :created, :location => @insure_result }
      else
        format.html { render :action => "new" }
        format.json { render :json => @insure_result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /insure_results/1
  # PUT /insure_results/1.json
  def update
    @insure_result = InsureResult.find(params[:id])

    respond_to do |format|
      if @insure_result.update_attributes(params[:insure_result])
        format.html { redirect_to @insure_result, :notice => 'Insure result was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @insure_result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /insure_results/1
  # DELETE /insure_results/1.json
  def destroy
    @insure_result = InsureResult.find(params[:id])
    @insure_result.destroy

    respond_to do |format|
      format.html { redirect_to insure_results_url }
      format.json { head :ok }
    end
  end
end
