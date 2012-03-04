class ApplicationController < ActionController::Base

    #layout proc{ |c| c.request.xhr? ? false : "application" }
    
   # layout "application"

  protect_from_forgery
end
