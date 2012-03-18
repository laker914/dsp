class ApplicationController < ActionController::Base

  #layout proc{ |c| c.request.xhr? ? false : "application" }

  # layout "application"

  protect_from_forgery

  before_filter :session_expiry,  :except => [:login, :session_login,:logout,:unlock]
  before_filter :update_activity_time, :except => [:login, :session_login,:logout ]
  before_filter :isvalid_auth, :except => [:login,:session_login, :logout ,:unlock , :cities_tree]

  def session_expiry
    if session[:expires_at].blank?
        reset_session
        if request.xhr?
            render  :json => {:success => false , :msg => "您的会话已失效,请点击右上角退出按钮"}
        else
            redirect_to :controller => "sessions" , :action => "session_login"
        end
    end
    @time_left = (session[:expires_at] - Time.now).to_i
    unless @time_left > 0
      reset_session
      if request.xhr?
          render  :json => {:success => false , :msg => "您的会话已失效,请点击右上角退出按钮"}
      else
          redirect_to :controller => "sessions" , :action => "session_login"
      end
    end
  end

  def update_activity_time
    session[:expires_at] = 480.minutes.from_now
  end

  def isvalid_auth
    if session[:user_id].blank?
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
