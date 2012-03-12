class Employee < ActiveRecord::Base
  
  # belongs_to :company
    
  # validates_uniqueness_of :empname , :scope  => :company ,:message => "员工姓名已存在"
  
  validates_uniqueness_of :empidn   , :scope => :company,  :message => I18n.t(:message_models_exist_empidn)
  
  scope :with_bargain_begin , lambda { |company , start_date , end_date | select("empname").where(" company = ? and bargain_begin between ? and ?" ,company ,start_date ,end_date ) }
  scope :with_bargain_end , lambda { |company , start_date , end_date| select("empname").where("company = ? and bargain_end between ? and ?" , company , start_date , end_date)  }
  # scope :company_count, lambda{ |company| where(" company = ?" , company).count }
  
  # how many employees in this company
  def self.company_count(value)
     where(" company = ?" , value).count
  end
  # get this year_month has peoples
  def self.count_employee(yearmonth)
      where(" extract(year_month from bargain_begin) <= ? and extract(year_month from bargain_end) >= ?" , yearmonth , yearmonth).count("id")
  end
  
  def self.by_company_sum
    Employee.group(:company).limit(10).order("count_id DESC ").count(:id)
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
