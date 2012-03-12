class InsureResult < ActiveRecord::Base
  has_many :insure_results_sub, :class_name => "InsureResultsSub", :foreign_key => "main_id" ,:dependent => :destroy
  
  scope :with_company_yearmonth , lambda{ |year , company_ids| where(" yearmonth = ? and company in (?)" , year , company_ids)  }
  
  scope :with_company_yearmonths , lambda{ |years , company_ids| where(" yearmonth in (?) and company in (?)" , years , company_ids)   }
  
  # years:      full year e.x 201201.201202.....201212
  # companyids: 
  # type: flag
  #       if the value is "=", then sum provident item 
  #          the value is ">",then sum insure item
  def self.full_year_money(years , companyids , type)
     insureResults = self.with_company_yearmonths(years , companyids)
     hash = {}
     if insureResults.blank? == false
          insureResults.each do |insure|
               key = insure.yearmonth + ";" + insure.company.to_s + ";" + insure.emp_id.to_s
               # if hash[key].blank?
               hash[key] = insure.insure_results_sub.where(" insure_type = 2 and insure_item #{type} ? ",1).sum(" insure_money")
               # end
          end
     end
     hash
  end
  
  def self.full_year_money_all(years , companyids,type)
    insureResults = self.with_company_yearmonths(years , companyids)
    hash = {}
    if insureResults.blank? == false
         insureResults.each do |insure|
              key = insure.yearmonth + ";" + insure.company.to_s + ";" + insure.emp_id.to_s
              # if hash[key].blank?
              hash[key] = [ insure.insure_results_sub.where(" insure_type = 1 and insure_item #{type} ? ",1).sum(" insure_money") ,
                          insure.insure_results_sub.where(" insure_type = 2 and insure_item #{type} ? ",1).sum(" insure_money")]
              # end
         end
    end
    hash
  end
  
  # get current year all the month
  def self.full_month(year="")
  	full = []
  	12.times.each do |i|
  	  month = i + 1
  	  month = "0" + month.to_s unless i > 8
  	  full << year.to_s + month.to_s
  	end
  	full
  end
end
