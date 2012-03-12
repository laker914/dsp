class InsureResultsSub < ActiveRecord::Base
  
  scope :with_sum_insure , where(" insure_item > ?" , 1).sum("insure_money")
  
  scope :with_sum_provident , where(" insure_item = ?" , 1).sum("insure_money")
  
  belongs_to :insure_result
  
  
  def sum_insure
     where(" insure_item > ?" , 1).sum("insure_money")
  end
  
  def sum_provident
    where(" insure_item = ?" , 1).sum("insure_money")
  end
  
end
