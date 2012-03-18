class ChartsController < ApplicationController
  
  def company
     list = []
     c_hash = Employee.by_company_sum
     c_hash.each_key do |key|
         company = Company.find(key)
         if params[:rmb].blank?
             list << { :company => company.ccname , :total => c_hash[key] }
         else
             money = company.rmb.to_d * c_hash[key].to_i
             list << { :company => company.ccname , :total => money}
         end
     end
     o_hash = Employee.other_company_sum
     num = 0
     o_hash.each_key do |key|
          num += o_hash[key].to_i
     end
     list << { :company => "其他",:total => num }
     respond_to do |format|
        format.json { render :json => {:data => list} }
     end
  end
  
  def business
     list = []
     year = Time.now.strftime("%Y")
     full_month = InsureResult.full_month(year)
     full_month.each do |year_month|
        sum_money = InsureResult.full_year_money(year_month)
        list << { :month  => year_month.sub(year,"").to_i.to_s + "月" , :money => sum_money }
     end
     respond_to do |format|
         format.json { render :json => { :data => list}}
     end
  end
  
  def employee
    # get all month by curr year
     list = []
     year = Time.now.strftime("%Y")
     full_month = InsureResult.full_month(year)
     full_month.each do |year_month|
        count_people = Employee.count_employee(year_month)
        list << { :name  => year_month.sub(year,"").to_i.to_s + "月" , :visits  =>  count_people , :views => count_people}
     end
     respond_to do |format|
        format.json { render :json => {:data => list} }
     end
  end
  
  def query
    respond_to do |format|
        format.js 
    end
  end
  
  def load_xml
    @data_str = []
    @data_str << "<chart caption='Weekly Sales Summary' xAxisName='Week' yAxisName='Amount' numberPrefix='$'> "
    @data_str << "<set label='Week 1' value='14400' />"
    @data_str << "<set label='Week 2' value='19600' />"
    @data_str << "<set label='Week 3' value='24000' />"
    @data_str << "<set label='Week 4' value='15700' />"
    @data_str << "</chart>"
    respond_to do |format|
      format.xml 
    end
  end

  def submit
  end

end
