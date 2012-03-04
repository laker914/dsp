class Employee < ActiveRecord::Base
    
  validates_uniqueness_of :empname , :scope  => :company ,:message => "exist record"
  
  
  def bargain_begin
     DateTime.parse(read_attribute(:bargain_begin).to_s).strftime('%Y-%m-%d').to_s
  end
  
  def bargain_end
     DateTime.parse(read_attribute(:bargain_end).to_s).strftime('%Y-%m-%d').to_s
  end
  
  def job_begin
     DateTime.parse(read_attribute(:job_begin).to_s).strftime('%Y-%m-%d').to_s
  end
  
end
