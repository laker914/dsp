class ReportPerminumDetailsController < ApplicationController
  def query
      respond_to  do |format|
        format.js
      end
  end

  def submit
    @employees = Employee.all
    render :layout  => false
  end

end
