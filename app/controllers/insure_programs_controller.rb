class InsureProgramsController < ApplicationController
  # GET /insure_programs
  # GET /insure_programs.json
  def index
    @insure_programs = InsureProgram.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @insure_programs }
    end
  end

  # GET /insure_programs/1
  # GET /insure_programs/1.json
  def show
    @insure_program = InsureProgram.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @insure_program }
    end
  end

  # GET /insure_programs/new
  # GET /insure_programs/new.json
  def new
    @insure_program = InsureProgram.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @insure_program }
    end
  end

  # GET /insure_programs/1/edit
  def edit
    @insure_program = InsureProgram.find(params[:id])
  end

  # POST /insure_programs
  # POST /insure_programs.json
  def create
    @insure_program = InsureProgram.new(params[:insure_program])

    respond_to do |format|
      if @insure_program.save
        format.html { redirect_to @insure_program, :notice => 'Insure program was successfully created.' }
        format.json { render :json => @insure_program, :status => :created, :location => @insure_program }
      else
        format.html { render :action => "new" }
        format.json { render :json => @insure_program.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /insure_programs/1
  # PUT /insure_programs/1.json
  def update
    @insure_program = InsureProgram.find(params[:id])

    respond_to do |format|
      if @insure_program.update_attributes(params[:insure_program])
        format.html { redirect_to @insure_program, :notice => 'Insure program was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @insure_program.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /insure_programs/1
  # DELETE /insure_programs/1.json
  def destroy
    @insure_program = InsureProgram.find(params[:id])
    @insure_program.destroy

    respond_to do |format|
      format.html { redirect_to insure_programs_url }
      format.json { head :ok }
    end
  end
end
