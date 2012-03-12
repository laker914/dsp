class ReportPerminumDetailsController < ApplicationController
  def query
      respond_to  do |format|
        format.js
      end
  end

  def submit
	@yearMont = Time.current.strftime("%Y")
	@full_year = InsureResult.full_month(@yearMont)
	@company = Company.find(params[:company_id])
	if params[:empName].blank?
		@employees = Employee.where(" company= ? ", params[:company_id])
	else
		@employees  = Employee.where(" company = ? and empname = ? " , params[:company_id] , params[:empName])
	end
	@moneys = InsureResult.full_year_money(@full_year , params[:company_id].split(",") , ">")
	render :layout  => false
      end

end
