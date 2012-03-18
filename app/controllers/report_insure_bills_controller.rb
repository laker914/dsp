class ReportInsureBillsController < ApplicationController
  def query
      respond_to  do |format|
        format.js
      end
  end
  # send mail
  # first 
  def send_to_mail
        load_init()
        @user = User.find(session[:user_id])
        @company.each do |company|
           	employees    = Employee.where(" company = ? ", company.id)
           	new_employee  = Employee.with_bargain_begin(company.id , @start_date , @end_date)
      	    quit_employee = Employee.with_bargain_end(company.id,@start_date,@end_date)

      	    @news = []
      	    @quits= []
      	    (new_employee || []).each do |employee|
      	        @news << employee.empname
      	    end
      	    (quit_employee || []).each do |employee|
      	        @quits << employee.empname
      	    end
      	    config = {
      	      :yearmonth => @yearmonth , 
      	      :moneysPerson => @moneysPerson , 
      	      :moneysCom => @moneysCom , 
      	      :new => @news , 
      	      :quit => @quits } 
            Excel.to_excel(company , config , employees)
            path = "#{Rails.root}/public/bill/#{@yearmonth}/#{company.ccname}.xls"
            begin 
              BillMailer.send_bill(company , path).deliver
            rescue
              puts company.ccname
              @msg = "邮件发送失败。"
            end
      end
    render :layout => false
  end

  def submit
        load_init()
      	render :layout  => false
   end
   
   private 
   def load_init
       @yearmonth = params[:CalMonth]
       @company_id = params[:company_id]
       if @company_id.blank?
          @company = Company.order(" ccode asc ").all
        else
          @company = Company.where(" id = ? " , @company_id).order(" ccode asc")
       end
       company_ids = []
       @company.each do |com|
           company_ids << com.id
       end
       # @employees = Employee.where(" company = ? ", params[:company_id])
       @moneysPerson = InsureResult.full_year_money_all(@yearmonth.to_s.split(",") , company_ids , ">")
       @moneysCom  = InsureResult.full_year_money_all(@yearmonth.to_s.split(",") , company_ids , "=")
     	 _year_month = @yearmonth
       _year_month = _year_month+"01"
       @start_date = DateTime.parse(_year_month)#.strftime('%Y-%m-%d')
       @end_date   = @start_date.end_of_month.to_s
   end
end
