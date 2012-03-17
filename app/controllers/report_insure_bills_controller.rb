class ReportInsureBillsController < ApplicationController
  def query
      respond_to  do |format|
        format.js
      end
  end

  def submit
        if params[:company_id].blank?
          @company = Company.order(" ccode asc ").all
        else
          @company = Company.where(" id = ? " , params[:company_id]).order(" ccode asc ")
        end
        company_ids = []
        @company.each do |com|
            company_ids << com.id
        end
        # @employees = Employee.where(" company = ? ", params[:company_id])
      	@moneysPerson = InsureResult.full_year_money_all(params[:CalMonth].split(",") , company_ids , ">")
      	@moneysCom  = InsureResult.full_year_money_all(params[:CalMonth].to_s.split(",") , company_ids , "=")
      	_year_month = params[:CalMonth]
        _year_month = _year_month+"01"
        @start_date = DateTime.parse(_year_month)#.strftime('%Y-%m-%d')
        @end_date   = @start_date.end_of_month.to_s
      	render :layout  => false
   end
end
