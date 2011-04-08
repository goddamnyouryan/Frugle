class HomeController < ApplicationController
  
  def index
    if user_signed_in?
      if current_user.role == "business"
        @business = current_user.business
        @map = GMap.new("map_div")
        @map.control_init(:large_map => true,:map_type => true)
        @map.center_zoom_init([@business.latitude,@business.longitude],14)
        @map.overlay_init(GMarker.new([@business.latitude,@business.longitude],:title => "#{@business.name}", :info_window => "#{@business.name} <br /> #{@business.address}<br />#{@business.zip}<br />#{@business.phone}"))
        @active_frugles = Frugle.find :all, :conditions => ["business_id = ? AND status = ?", @business.id, "active"]
        @expired_frugles = Frugle.find :all, :conditions => ["business_id = ? AND status = ?", @business.id, "expired"]
      else
        @neighborhood = Neighborhood.find current_user.neighborhood_id
        redirect_to :controller => "neighborhoods", :action => "show", :id => @neighborhood.friendly_id
      end
    else
      if session[:neighborhood]
        @neighborhood = Neighborhood.find session[:neighborhood]
        redirect_to :controller => "neighborhoods", :action => "show", :id => @neighborhood.friendly_id
      else
        redirect_to new_user_registration_path
      end
    end
  end
  
end
