class Company < ActiveRecord::Base
  
  def self.scope_than
     company = Company.all
     company_array = []
     # company_array << ["所有",""]
     company.each do |c|
         company_array << ["#{c.ccname}", c.id]
     end
     company_array
  end
  
  scope :with_select_options ,scope_than
  
    # has_many :users, :class_name => "user", :foreign_key => "company"
    
    validates_presence_of :ccode  , :message => "can't be blank"
    validates_uniqueness_of :ccode, :message => "must be unique"
    
    def self.company_than(ids=[])
        if ids.blank?
          Company.all
        else
          where(:id => ids)
        end
    end
    
end
