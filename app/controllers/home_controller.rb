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
  
  def users_admin
    @users = User.all
  end
  
  def businesses_admin
    @businesses = Business.paginate :all, :page => params[:page]
  end
  
  def frugles_admin
    @frugles = Frugle.paginate :all, :page => params[:page], :per_page => 100
  end
  
  def delete_user
    @user = User.find params[:user_id]
    @user.destroy
    redirect_to users_admin_path, :notice => "Successfully Deleted User."
  end
  
  def delete_business
    @business = Business.find params[:business_id]
    @user = @business.user
    @business.destroy
    unless @user.nil?
      @user.destroy
    end
    redirect_to businesses_admin_path, :notice => "Successfully Deleted Business."
  end
  
  def delete_frugle
    @frugle = Frugle.find params[:frugle_id]
    @frugle.destroy
    redirect_to frugles_admin_path, :notice => "Successfully Deleted Frugle."
  end
  
end
