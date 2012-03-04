class CompanyAccount < ActiveRecord::Base

    def self.account_by_company(ids=[])
       find(:all ,
          :conditions => [" companys.id in (?) " , ids ],
          :joins => " inner join companies as companys on companys.province = company_accounts.province and companys.city = company_accounts.city and companys.area = company_accounts.area")
    end
end
