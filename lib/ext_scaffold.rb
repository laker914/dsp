module ExtScaffold
  
  protected
  
  def pagination_state 
    #:offset => params.delete(:start) ,
    { :limit => params.delete(:limit)}
  end
  # querys = params[:filter]
  #  unless [querys].any?(&:blank?)
  #      #ActiveSupport::JSON::decode(querys).each do |query|
  #      querys.each do |i , query|
  #        puts "测试数据"
  #        puts query["data"]["type"]
  #        puts query[:data][:value]
  #        puts query[:field]
  #      end
  #  end
  def options_from_filter(_options = {})
    curpage = params[:start] || 1
    limit   = params[:limit] || 20
    curpage = 1 if curpage.to_i == 0
    curpage = curpage.to_i / limit.to_i + 1
    # when query total, it isn't need :page & :per_page for split page
    options = _options[:data] ? { :page => curpage, :per_page => params[:limit]} : {}
       search_conditions = []
       # grid-filter
       unless [params[:filter]].any?(&:blank?)
              ActiveSupport::JSON.decode(params[:filter]).each do |query|
              puts query.class
              puts query["value"]
              column = query["field"] 
              value  = query["value"]
              search_conditions << "#{column} LIKE '%#{value}%'"
          end
       end
       # grid-formpanel
       unless [params[:query]].any?(&:blank?)
            query =  ActiveSupport::JSON.decode(params[:query]) 
            query.each do |key , value|
                 search_conditions << "#{key} LIKE '%#{value}%'" unless value.blank?
            end
       end
       
    options.merge!(
            :conditions => search_conditions.join(' AND ')
          ) unless search_conditions.empty?
    options
  end
  
end