class Company < ActiveRecord::Base
  
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
