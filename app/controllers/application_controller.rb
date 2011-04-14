class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "application"
  before_filter :fix_ct
  
    def fix_ct
      headers["Content-Type"] = "text/html" 
    end
end
