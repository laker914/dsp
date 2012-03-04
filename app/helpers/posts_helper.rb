module PostsHelper
  
  def post_load_ext(options = {})
       renderto = options[:renderto] || "leftcolumn"

       javascript_tag <<-_JSCODE
            alert('as');
      _JSCODE
  end
  
end
