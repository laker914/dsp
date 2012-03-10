class InsureResult < ActiveRecord::Base
  has_many :insure_results_sub, :class_name => "InsureResultsSub", :foreign_key => "main_id" ,:dependent => :destroy
  
  scope :with_company_yearmonth , lambda{ |year , company_ids| where(" yearmonth = ? and company in (?)" , year , company_ids)  }
end
