class SessionsController < ApplicationController
  layout 'session'
  
  def update_password
     @user = User.authenticate(session[:user_account],params[:old_password])
     respond_to do |format|
       flag = 0
       success = false
        if @user
          @user.password = params[:password]
            if @user.update_attribute("hashed_password",@user.hashed_password)
                success = true 
                flag = 1
            else
                flag = -1
            end
        end
        format.json { render :json => {:success => success , :flag => flag}}
     end
  end
  
  def unlock
      password = params[:password]
      @user = User.authenticate(session[:user_account],password)
      respond_to do |format|
        if @user
           format.json {render :json => {:success => true }}
        else
           format.json {render :json => {:success => false , :msg => "密码不对,请重新输入"}}
        end
      end

  end
  
  def login 
     s_domain = request.subdomains.first.to_s
     if request.get?
        @user = User.new
        # render  :layout => "session"
      elsif request.post? 
        respond_to  do |format|
            success   = false
            errorType = 0
            client_ip = request.ip()
            @login    = params[:account]
            @password = params[:password]
            @user     = User.authenticate(@login,@password)
            if @user  
                 @user.update_attribute('login_ip',client_ip)
                 session[:user_id] = @user.id
                 session[:user_account] = @user.login
                 session[:user_name] = @user.login_name
                success = true
                # redirect_to({:controller => "homepages" , :action => "index"})
            else
                reset_session
                errorType = 1
                msg = t(:message_account_nofound)
                # redirect_to :action => "login" ,:layout => "session"
            end
            format.json { render :json => { :success => success , :msg => msg , :url => "homepages/index" , :errorType => errorType } }
        end
     end
  end

  def logout
      session[:user_id] = nil
      session[:expires_at] = Time.now
      reset_session
      redirect_to :action => "login"
  end

end
