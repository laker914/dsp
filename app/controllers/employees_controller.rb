class EmployeesController < ApplicationController
  
   include ExtScaffold
  # GET /employees
  # GET /employees.json
  def index
     respond_to do |format|
         format.js
     end
   end

   def grid
       #@companies = Company.find(:all , pagination_state.merge(options_from_filter()))
       logger.info("===============================")
       @employees = Employee.paginate options_from_filter({:data => Employee})
       #(options_from_filter)
       respond_to do |format|
           format.json { render :json => {:success => true , :data => @employees , :total => Employee.count(options_from_filter())} }
       end
   end
   
   def delete
       keys = params[:dlist]
       success = false;
       notice = "";
       if not keys.nil?
           begin
             Employee.transaction do
                 keys.each do |key|
                   if key != ""
                      @employee = Employee.find(key)
                      @employee.destroy
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

  # GET /employees/1
  # GET /employees/1.json
  def show
    @employee = Employee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @employee }
    end
  end

  # GET /employees/new
  # GET /employees/new.json
  def new
    @employee = Employee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @employee }
    end
  end

  # GET /employees/1/edit
  def edit
    @employee = Employee.find(params[:id])
    puts @employee.to_ext_json
     respond_to do |format|
          format.html #edit.html.erb
          format.json { render :json  => @employee.to_ext_json  , :success => true }
      end
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(params[:employee])
    @employee.job_begin = "2012-01-01" if @employee.job_begin.blank?
    @employee.is_insure = 0
    @employee.is_provident = 0
    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, :notice => 'Employee was successfully created.' }
        format.json { render :json => {:success => true , :data => @employee}, :status => :created, :location => @employee }
      else
        format.html { render :action => "new" }
        format.json { render :json => { :msg => @employee.errors , :status => :unprocessable_entity }}
      end
    end
  end

  # PUT /employees/1
  # PUT /employees/1.json
  def update
    @employee = Employee.find(params[:id])

    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        format.html { redirect_to @employee, :notice => 'Employee was successfully updated.' }
        # format.json { head :ok }
         format.json {render :json => {:data => @employee ,  :success  => true } }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @employee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url }
      format.json { head :ok }
    end
  end
  #社保管理页面
  def insure
    respond_to do |format|
       format.js
    end
  end
  
  
  
  # 公积金管理页面
  def provident
    respond_to do |format|
      format.js
    end
  end
end
