class ReportPerminumDetailsController < ApplicationController
  def query
      respond_to  do |format|
        format.js
      end
  end

  def submit
	    @yearMont = Time.current.strftime("%Y")
    	@full_year = InsureResult.full_month(@yearMont)
    	company_ids = []
    	if params[:company_id].blank?
    	  @company = Company.order(" ccode asc ").all
      else
        @company = Company.where("id = ?" , params[:company_id]).order(" ccode asc ")
    	end
    	@company.each do |com|
    	    company_ids << com.id
    	end
    	if params[:empName].blank?
    		@employees  = Employee.where(" company in (?) ", company_ids)
    	else
    		@employees  = Employee.where(" company in (?) and empname = ? " , company_ids , params[:empName])
    	end
      # 判断有多少公司
    	@newcompany = {}
    	@company.each do |com|
    	    @employees.each do |employee|
    	          @newcompany[com.id] = com  if @newcompany[employee.company].blank?
    	    end
    	end
    	@moneys = InsureResult.full_year_money(@full_year , company_ids , ">")
    	render :layout  => false
    end

end
