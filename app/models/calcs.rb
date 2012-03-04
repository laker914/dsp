class Calcs < ActiveRecord::Base
  
  def calc_insure
      # get first date by month e.g.  2012-02-01
      @firstMonth =  getdate_by_yearmonth
      # get last date by month  e.g.  2012-02-29
      @lastMonth  =  @firstMonth.to_date.end_of_month.to_s
      
      employees = findEmployees(@firstMonth , @lastMonth)
      
      companys  = getcompany
      
      @company_hash = company_to_hash(companys)
      
      loop_employees(employees)
  end
  
  def findEmployees(firstMonth , lastMonth)
      Employee.find(:all , :conditions => [" bargain_begin <= ? and bargain_end >= ?" , lastMonth , firstMonth ])
  end
  
  private 
  # main logic first
  # 1. first get employee's company id ,then know how items for this company
  # 
    def loop_employees(employees={})
        _company = nil
        com_accounts = CompanyAccount.account_by_company(need_calc_company)
        # if (com_accounts.blank?) 
            # puts "not config company accounts ,please go to config."
            # return ;
        
        # change array to hash
        com_accounts_hash = accounts_to_hash(com_accounts)
        psn_accounts = PersonalAccount.account_by_personal(need_calc_company)
        # if (psn_accounts.blank?) 
            # puts "not config personal accounts ,please go to config."
            # return ;
        
        # change array to hash
        psn_accounts_hash = accounts_to_hash(psn_accounts)
         employees.each do |employee|
            _company = @company_hash[employee.company.to_s]
            keys = _company.province + ";"+_company.city+";"+_company.area+";"+employee.hukou.to_s
            # get company account for employee
            puts keys 
            puts com_accounts_hash
            with_items_company = com_accounts_hash[keys]
            # if (with_items_company.blank?)  
               # puts "this employee no config company accounts"
            # get personal account for employee
            with_items_personal = psn_accounts_hash[keys]
            # if (with_items_personal.blank?)
               # puts "this employee no config personal accounts"
            insureResult = InsureResult.new(:company => employee.company , 
                :emp_id => employee.id , :emp_name => employee.empname,
                :yearmonth => self[:yearmonth] , :hukou => employee.hukou)
            insureResult.save!   
            if with_items_company.blank? == false
                company_items(insureResult.id , with_items_company , employee)
            end
            if with_items_personal.blank? == false
                personal_items(insureResult.id , with_items_personal ,employee)              
            end
         end
    end
    # company items
    def company_items(keys , with_items_company , employee)
        with_items_company.each do |items|
          if employee.is_insure == 0 and items.id > 1
              puts "this employee is not config insure items"
          end
          
          if employee.is_provident == 0 and items.id == 1
              pus "this employee is not config provident items."
          end
          base = items.id == 1 ? employee.provident_base : employee.insure_base
          value = base * items.rate / 100
          value = items.fix_value unless items.company_type == 1 
          
          value = compare(items.company_lower , items.company_limit , value)
          
          sub = InsureResultsSub.new(:main_id => keys , :insure_type => 1 , :insure_base => base , :insure_item => items.id , :insure_money => value)
          sub.save
      end
    end
    # personal items
    def personal_items(keys , with_items_personal ,employee)
       with_items_personal.each do |items|
           if employee.is_insure == 0 and items.id > 1
              puts "this employee is not config insure items"
           end
           if employee.is_provident == 0 and items.id == 1
              pus "this employee is not config provident items."
           end
           base = items.id == 1 ? employee.provident_base : employee.insure_base
           value = base * items.rate / 100 
           value = items.fix_value unless items.personal_type == 1
           
           value = compare(items.personal_lower , items.personal_limit , value)
           
           sub = InsureResultsSub.new(:main_id => keys , :insure_type => 2 , :insure_base => base , :insure_item => items.id , :insure_money => value)
          sub.save
       end
    end
    
    # compare 
    def compare(lower , limit , value)
       value = value < lower ? lower : value;
       value = value > limit ? limit : value;
       value
    end
  
    # get first date
    def getdate_by_yearmonth
        _year_month = self[:yearmonth]
        # default to first day by current month
        _year_month = _year_month+"01"
        DateTime.parse(_year_month).strftime('%Y-%m-%d')
    end
    # get companys information by conditions
    def getcompany
        Company.company_than(need_calc_company)
    end
    
    # the need to calc company id from UI pages
    def need_calc_company
        company_ids = []
        company_ids = self[:company].split(",") unless self[:company].blank?
        company_ids
    end
    
  
  # change Array type to Hash Width Company Model
  # example:
  #     {"1" => Company.new}
  #     {"2" => Company.new}
  #     {"3" => Company.new}
  # 
    def company_to_hash(company_array=[])
        company_hash = {}
        company_array.each do |a|
          # key => pk , value => Company
            company_hash[a.id.to_s] = a 
        end
        company_hash
    end
    # 帐套配置 -》
    def accounts_to_hash(accounts=[])
        c_a_hash = {}
        accounts.each do |account|
          keys = account.province+';'+account.city+';'+account.area+';'+account.hukou.to_s
          c_a_hash[keys]  = [] if c_a_hash[keys].blank?
          c_a_hash[keys] << account
        end
        c_a_hash
    end
end
