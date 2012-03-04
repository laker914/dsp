class ReportEmpsController < ApplicationController
  
  def query
      respond_to  do |format|
        format.js
      end
  end

  def submit
  end

end
