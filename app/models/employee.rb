class Employee < ActiveRecord::Base
  
  # belongs_to :company
    
  # validates_uniqueness_of :empname , :scope  => :company ,:message => "员工姓名已存在"
  
  validates_uniqueness_of :empidn   , :scope => :company,  :message => I18n.t(:message_models_exist_empidn)
  
  # scope :company_count, lambda{ |company| where(" company = ?" , company).count }
  
  # how many employees in this company
  def self.company_count(value)
     where(" company = ?" , value).count
  end
  
  def bargain_begin
     DateTime.parse(read_attribute(:bargain_begin).to_s).strftime('%Y-%m-%d').to_s
  end
  
  def bargain_end
     DateTime.parse(read_attribute(:bargain_end).to_s).strftime('%Y-%m-%d').to_s
  end
  
  def job_begin
     DateTime.parse(read_attribute(:job_begin).to_s).strftime('%Y-%m-%d').to_s
  end
  
  def hire_date
     DateTime.parse(read_attribute(:hire_date).to_s).strftime('%Y-%m-%d').to_s
  end
end
