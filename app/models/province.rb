class Province < ActiveRecord::Base
  
  def self.list
     @@list = find.all
     @@list
  end
  
end
