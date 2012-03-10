class CompaniesController < ApplicationController
  
  include ExtScaffold
  
  # GET /companies
  # GET /companies.json
  def index
    respond_to do |format|
        format.js
    end
  end
  
  def grid
      #@companies = Company.find(:all , pagination_state.merge(options_from_filter()))
      logger.info("===============================")
      @companies = Company.paginate options_from_filter({:data => Company})
      #(options_from_filter)
      respond_to do |format|
          format.json { render :json => {:success => true , :data => @companies , :total => Company.count(options_from_filter())} }
      end
  end
  
  def delete
      keys = params[:dlist]
      success = false
      notice = ""
      hasEmployee = []
      if not keys.nil?
           begin
            Company.transaction do
                keys.each do |key|
                  if key != ""
                     @company = Company.find(key)
                     count = Employee.company_count(@company.id)
                     if count > 0
                        hasEmployee << t(:message_controllers_notices_hasexist , :name => @company.ccname , :count  => count)
                    else 
                        @company.destroy
                     end
                  end
                end
              end
              if hasEmployee.blank? == false
                notice = t(:message_controllers_notices_success) + '<br>'+ t(:message_controllers_notices_but) + hasEmployee.join('<br>')
              end
           rescue 
               success = false
               notice = t(:message_controllers_notices_failed)
          end
      end
      respond_to do |format|
          format.json { render :json  => {:success => true , :msg => notice}}
      end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
    respond_to do |format|
        format.html #edit.html.erb
        format.json { render :json  => @company.to_ext_json  , :success => true }
    end
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(params[:company])
    @company.py_code = @company.ccode
    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, :notice => 'Company was successfully created.' }
        format.json { render :json => {:data => @company , :success => true}, :status => :created, :location => @company } 
      else
        format.html { render :action => "new" }
        format.json { render :json => { :msg => @company.errors , :status => :unprocessable_entity }}
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, :notice => 'Company was successfully updated.' }
        #format.json { head :ok }
        format.json {render :json => {:data => @company ,  :success  => true } }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @company.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :ok }
    end
  end
end
