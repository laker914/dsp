class CompanyAccountsController < ApplicationController
  
  include ExtScaffold
    
  # GET /company_accounts
  # GET /company_accounts.json
  def index
    respond_to do |format|
        format.js
    end
  end
  
  def grid
      logger.info("===============================")
      @companyAccount = CompanyAccount.paginate options_from_filter({:data => CompanyAccount})
      #(options_from_filter)
      
      respond_to do |format|
          format.json { render :json => {:success => true , :data => @companyAccount , :total => CompanyAccount.count(options_from_filter())} }
      end
  end
  
  def delete
      keys = params[:dlist]
      success = false;
      notice = "";
      if not keys.nil?
          begin
            CompanyAccount.transaction do
                keys.each do |key|
                  if key != ""
                     @companyAccount = CompanyAccount.find(key)
                     @companyAccount.destroy
                  end
                end
              end
               notice = t(:message_controllers_notices_success)
            rescue 
                success = false;
                notice = t(:message_controllers_notices_failed)
          end
      end
      respond_to do |format|
          format.json { render :json  => {:success => true , :msg => notice}}
      end
  end
 

  # GET /company_accounts/1
  # GET /company_accounts/1.json
  def show
    @company_account = CompanyAccount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @company_account }
    end
  end

  # GET /company_accounts/new
  # GET /company_accounts/new.json
  def new
    @company_account = CompanyAccount.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @company_account }
    end
  end

  # GET /company_accounts/1/edit
  def edit
    @company_account = CompanyAccount.find(params[:id])
    respond_to do |format|
        format.html #edit.html.erb
        format.json { render :json  => @company_account.to_ext_json  , :success => true }
    end
  end

  # POST /company_accounts
  # POST /company_accounts.json
  def create
    @company_account = CompanyAccount.new(params[:company_account])

    respond_to do |format|
      if @company_account.save
        format.html { redirect_to @company_account, :notice => 'Company account was successfully created.' }
        format.json { render :json => {:data => @company_account , :success => true }, :status => :created, :location => @company_account }
      else
        format.html { render :action => "new" }
        format.json { render :json => {:msg => @company_account.errors, :status => :unprocessable_entity} }
      end
    end
  end

  # PUT /company_accounts/1
  # PUT /company_accounts/1.json
  def update
    @company_account = CompanyAccount.find(params[:id])

    respond_to do |format|
      if @company_account.update_attributes(params[:company_account])
        format.html { redirect_to @company_account, :notice => 'Company account was successfully updated.' }
        # format.json { head :ok }
        format.json {render :json => {:data => @company_account ,  :success  => true } }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @company_account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /company_accounts/1
  # DELETE /company_accounts/1.json
  def destroy
    @company_account = CompanyAccount.find(params[:id])
    @company_account.destroy

    respond_to do |format|
      format.html { redirect_to company_accounts_url }
      format.json { head :ok }
    end
  end
end
