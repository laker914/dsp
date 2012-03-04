module ApplicationHelper
  
  #show the all companies in javascript tag
  #use employee/index.html.erb
  def company_for
     @companys = Company.all
     a = ""
     @companys.each do |company|
          a += ",['#{company.id}','#{company.ccname}',#{company.insure_base},#{company.provident_base}]"
     end
     a = a.split(//)[1,a.length]
     javascript_tag <<-_JS
          var COM = [#{a}];
     _JS
  end
  
  # use company_accounts/index.html.erb
  def insure_item_for
    @insure_items = InsureProgram.all
    a = ""
    @insure_items.each do |item|
        a += ",['#{item.id}','#{item.insure_name}']"
    end
    a = a.split(//)[1,a.length]
    javascript_tag <<-_JS
        var ITEM = [#{a}];
    _JS
  end
  
  # use insure_results/calc.html.erb
  def company_for_checkbox
      @companys = Company.find(:all)
      check = ""
      @companys.each do | company |
          check+= ",{boxLabel:'#{company.ccname}',name:'company',inputValue:'#{company.id}',checked:true}"
      end
      check = check.split(//)[1,check.length]
      javascript_tag <<-_JS
          var COM_CHECK = [#{check}]
      _JS
  end
end