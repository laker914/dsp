class ApplicationController < ActionController::Base

    #layout proc{ |c| c.request.xhr? ? false : "application" }
    
   # layout "application"

  protect_from_forgery
  
  before_filter :isvalid_auth, :except => [:login, :logout ,:unlock , :cities_tree]
  
  def isvalid_auth
      if session[:user_id].blank?
         puts "哈哈,你的权限失效了啊"
         redirect_to_login
      end
  end
  
  def render_404(options={})
     render_error({:message => :message_file_not_found,:status => 404}.merge(options))
     return false
  end
  
   # Renders an error response
  def render_error(arg)
      arg = {:message => arg} unless arg.is_a?(Hash)

      @message = arg[:message]
      @message = l(@message) if @message.is_a?(Symbol)
      @status = arg[:status] || 500

      respond_to do |format|
        format.html {
          render :template => 'public/404.html', :layout => 'user', :status => @status
        }
        format.xml { head @status }
        format.js { head @status }
        format.json { head @status }
      end
   end
      
    def redirect_to_login 
        redirect_to :controller => "sessions" ,:action => "login"
    end
end
