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
        @user_subcategories = current_user.subcategories
        @results = Array.new
        @user_subcategories.each do |s|
          @search = Frugle.find :all, :include => :business, :conditions => [ "businesses.subcategory_id = ? AND businesses.neighborhood_id = ?", s.id, current_user.neighborhood_id]
          @results = @results | @search
        end
      end
    else
      unless session[:neighborhood]
        redirect_to new_user_registration_path
      end
    end
  end

end
