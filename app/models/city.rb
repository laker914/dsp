class City < ActiveRecord::Base
  acts_as_nested_set
  
  def children_count
    return (self[right_col_name] - self[left_col_name] - 1 ) / 2 
  end
  
  def leaf?
    # unknown? || children_count == 0
    children_count == 0
  end
  
  def self.encode(id)
     str = ""
     if not id.nil? then  
         begin
           self.self_and_ancestors.each do |c|
               if not (c.name.include? '中国')
                  str += c.name
               end
           end
           return str
         rescue Exception => exc
           logger.error("#{exc.message}")
           return ""
         end
     end
  end
end
