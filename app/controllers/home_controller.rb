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
        @map = GMap.new("map_div")
        @map.control_init(:large_map => true,:map_type => true)
        @map.center_zoom_init([34.0412085, -118.442596],10)
        unless @results == nil
          for frugle in @results
            @map.overlay_init(GMarker.new([frugle.business.latitude,frugle.business.longitude],:title => "#{frugle.business.name}", :info_window => "#{frugle.business.name} <br /> #{frugle.business.address}<br />#{frugle.business.zip}<br />#{frugle.business.phone}"))
          end
        end
      end
    else
      unless session[:neighborhood]
        redirect_to new_user_registration_path
      end
    end
  end

end
