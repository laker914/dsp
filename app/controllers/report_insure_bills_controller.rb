class ReportInsureBillsController < ApplicationController
  def query
      respond_to  do |format|
        format.js
      end
  end

  def submit
	      @company = Company.find(params[:company_id])
      	@employees = Employee.where(" company= ? ", params[:company_id])
      	@moneysPerson = InsureResult.full_year_money_all(params[:CalMonth].split(",") , params[:company_id].split(",") , ">")
      	@moneysCom = InsureResult.full_year_money_all(params[:CalMonth].to_s.split(",") , params[:company_id].split(",") , "=")
      	_year_month = params[:CalMonth]
        _year_month = _year_month+"01"
        start_date = DateTime.parse(_year_month)#.strftime('%Y-%m-%d')
        end_date  = start_date.end_of_month.to_s
        new_employee  = Employee.with_bargain_begin(params[:company_id] , start_date , end_date)
        quit_employee = Employee.with_bargain_end(params[:company_id],start_date,end_date)
        
        @news = []
        @quits= []
        (new_employee || []).each do |employee|
            @news << employee.empname
        end
        (quit_employee || []).each do |employee|
            @quits << employee.empname
        end
      	render :layout  => false
   end
end
