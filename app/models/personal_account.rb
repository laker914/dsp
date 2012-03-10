class PersonalAccount < ActiveRecord::Base
  
  validates_uniqueness_of :item_id,:scope => [:hukou , :city_id] , :message => I18n.t(:message_models_exist_account_by_company)
  
  def self.account_by_personal(ids=[])
     find_by_sql(" SELECT distinct `personal_accounts`.* FROM `personal_accounts` inner join companies as companys on companys.city_id = personal_accounts.city_id where companys.id in (#{ids.join(',')})" )
  end
end
