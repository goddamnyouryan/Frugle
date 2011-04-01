class HomeController < ApplicationController
  
  def index
    if user_signed_in?
      if current_user.role == "business"
        @business = current_user.business
        @active_frugles = Frugle.find :all, :conditions => ["business_id = ? AND status = ?", @business.id, "active"]
        @expired_frugles = Frugle.find :all, :conditions => ["business_id = ? AND status = ?", @business.id, "expired"]
      else
        @categories = Category.find :all, :order => "title ASC"
        @user_categories = current_user.categories
      end
    else
      redirect_to new_user_registration_path
    end
  end

end
