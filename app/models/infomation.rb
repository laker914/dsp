class Infomation < ActiveRecord::Base
  
  cattr_accessor :available_systemsettings
  
  @@available_systemsettings = Infomation.find(1)
end
