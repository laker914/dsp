class CompanyAccount < ActiveRecord::Base
  
  validates_uniqueness_of :item_id,:scope => [:hukou , :city_id] , :message => I18n.t(:message_models_exist_account_by_company)

    def self.account_by_company(ids=[])
        find_by_sql(" SELECT distinct `company_accounts`.* FROM `company_accounts` inner join companies as companys on companys.city_id = company_accounts.city_id where companys.id in (#{ids.join(',')})" )
       # find(:all ,  :conditions => [" companys.id in (?) " , ids ], :joins => " inner join companies as companys on companys.city_id = company_accounts.city_id ")
    end
     
end
