class ReportEmpsController < ApplicationController
  
  def query
      respond_to  do |format|
        format.js
      end
  end

  def submit
    @company = Company.find(params[:company_id])
    @employees = Employee.where(" company = ? ",params[:company_id])
    render :layout  => false
  end

end
