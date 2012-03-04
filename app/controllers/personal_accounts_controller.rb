class PersonalAccountsController < ApplicationController
  
    include ExtScaffold
  # GET /personal_accounts
  # GET /personal_accounts.json
  def index
     respond_to do |format|
         format.js
     end
   end

   def grid
       logger.info("===============================")
       @personalAccount = PersonalAccount.paginate options_from_filter({:data => PersonalAccount})
       #(options_from_filter)
       respond_to do |format|
           format.json { render :json => {:success => true , :data => @personalAccount , :total => PersonalAccount.count(options_from_filter())} }
       end
   end

   def delete
       keys = params[:dlist]
       success = false;
       notice = "";
       if not keys.nil?
           begin
             PersonalAccount.transaction do
                 keys.each do |key|
                   if key != ""
                      @personalAccount = PersonalAccount.find(key)
                      @personalAccount.destroy
                   end
                 end
               end
               notice = "删除数据成功!"
           rescue 
               success = false;
               notice = "删除数据失败!"
           end
       end
       respond_to do |format|
           format.json { render :json  => {:success => true , :msg => notice}}
       end
   end

  # GET /personal_accounts/1
  # GET /personal_accounts/1.json
  def show
    @personal_account = PersonalAccount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @personal_account }
    end
  end

  # GET /personal_accounts/new
  # GET /personal_accounts/new.json
  def new
    @personal_account = PersonalAccount.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @personal_account }
    end
  end

  # GET /personal_accounts/1/edit
  def edit
    @personal_account = PersonalAccount.find(params[:id])
    respond_to do |format|
        format.html #edit.html.erb
        format.json { render :json  => @personal_account.to_ext_json  , :success => true }
    end
  end

  # POST /personal_accounts
  # POST /personal_accounts.json
  def create
    @personal_account = PersonalAccount.new(params[:personal_account])

    respond_to do |format|
      if @personal_account.save
        format.html { redirect_to @personal_account, :notice => 'Personal account was successfully created.' }
        format.json { render :json => {:data => @personal_account , :success => true }, :status => :created, :location => @personal_account }
      else
        format.html { render :action => "new" }
        format.json { render :json => {:msg => @personal_account.errors, :status => :unprocessable_entity} }
      end
    end
  end

  # PUT /personal_accounts/1
  # PUT /personal_accounts/1.json
  def update
    @personal_account = PersonalAccount.find(params[:id])

    respond_to do |format|
      if @personal_account.update_attributes(params[:personal_account])
        format.html { redirect_to @personal_account, :notice => 'Personal account was successfully updated.' }
        # format.json { head :ok }
        format.json {render :json => {:data => @personal_account ,  :success  => true } }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @personal_account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /personal_accounts/1
  # DELETE /personal_accounts/1.json
  def destroy
    @personal_account = PersonalAccount.find(params[:id])
    @personal_account.destroy

    respond_to do |format|
      format.html { redirect_to personal_accounts_url }
      format.json { head :ok }
    end
  end
end
