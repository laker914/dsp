class PersonalAccount < ActiveRecord::Base
  
  def self.account_by_personal(ids=[])
     find(:all ,
        :conditions => [" companys.id in (?) " , ids ],
        :joins => " inner join companies as companys on companys.province = personal_accounts.province and companys.city = personal_accounts.city and companys.area = personal_accounts.area")
  end
end
