class ReportEmpsController < ApplicationController
  
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
    @employees = Employee.where(" company in (?) ", company_ids)
    render :layout  => false
  end

end
