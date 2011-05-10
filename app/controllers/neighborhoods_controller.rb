class NeighborhoodsController < ApplicationController
  def index

  end
  
  def initial
    session[:neighborhood] = params[:neighborhood_id]
    render :update do |page|
	    page.visual_effect :fade, "box", :duration=>0.25
	    page.delay(0.5) do
	      page.visual_effect :appear, "sign_up", :duration=>0.25
      end
	  end
  end

  def show
    @neighborhood = Neighborhood.find(params[:id])
    @frugle_count = Frugle.find :all, :include => :business, :conditions => ["businesses.neighborhood_id = ?", @neighborhood.id ]
    @business_count = Business.find :all, :conditions => ["neighborhood_id = ?", @neighborhood.id ]
    if user_signed_in?
      if current_user.role == "business"
        redirect_to home_path
      else
        @categories = Category.find :all, :order => "title ASC"
        @featured = Frugle.find :all, :order => "prints ASC", :limit => 3, :include => :business, :conditions => [ "businesses.neighborhood_id = ?", current_user.neighborhood_id]
        @user_categories = current_user.categories
        @user_subcategories = current_user.subcategories
        @results = Array.new
        @user_subcategories.each do |s|
          @search = Frugle.find :all, :include => :business, :conditions => [ "businesses.subcategory_id = ? AND businesses.neighborhood_id = ?", s.id, current_user.neighborhood_id]
          @results = @results | @search
        end
        @map = GMap.new("map_div")
        @map.control_init(:large_map => true,:map_type => true)
        @map.center_zoom_init([@neighborhood.latitude, @neighborhood.longitude],13)
        unless @results == nil
          for frugle in @results
            @overlay = Frugle.find :all, :conditions => ["business_id = ?", frugle.business.id], :limit => 5
            @map.overlay_init(GMarker.new([frugle.business.latitude,frugle.business.longitude],:title => "#{frugle.business.name}", 
                              :info_window => "<a href=\"#{business_path(frugle.business)}\" style=\"font-weight:bold\">#{frugle.business.name}</a> <br /> #{frugle.business.address}<br />#{frugle.business.zip}<br />#{frugle.business.phone}<br /><a href=\"#{business_url(frugle.business)}\" style=\"font-weight:bold\">View Frugle</a>"))
          end
        end
      end
    else
      unless session[:neighborhood]
        redirect_to new_user_registration_path
      end
      @session_id = request.session_options[:id]
      @user = User.find_by_logged_out("#{@session_id}")
      if @user == nil
        @user = User.create(:email => "#{@session_id}@logged_out.com", :password => "logged_out", :password_confirmation => "logged_out", :first_name => "logged", :last_name => "out", :birthday => Time.now, :sex => "male")
        @user.logged_out = "#{@session_id}"
        @user.save
      end
      @categories = Category.find :all, :order => "title ASC"
      @featured = Frugle.find :all, :order => "views ASC", :limit => 3, :include => :business, :conditions => [ "businesses.neighborhood_id = ?", session[:neighborhood]]
      @user_categories = @user.categories
      @user_subcategories = @user.subcategories
      @results = Array.new
      @user_subcategories.each do |s|
        @search = Frugle.find :all, :include => :business, :conditions => [ "businesses.subcategory_id = ? AND businesses.neighborhood_id = ?", s.id, session[:neighborhood]]
        @results = @results | @search
      end
      @map = GMap.new("map_div")
      @map.control_init(:large_map => true,:map_type => true)
      @map.center_zoom_init([34.0412085, -118.442596],15)
      unless @results == nil
        for frugle in @results
          @map.overlay_init(GMarker.new([frugle.business.latitude,frugle.business.longitude],:title => "#{frugle.business.name}", :info_window => "#{frugle.business.name} <br /> #{frugle.business.address}<br />#{frugle.business.zip}<br />#{frugle.business.phone}"))
        end
      end
    end
  end

  def new
    if user_signed_in?
      if current_user.role == "admin"
        @neighborhood = Neighborhood.new
        @neighborhoods = Neighborhood.all
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def butthole
    @neighborhood = Neighborhood.create(params[:neighborhood])
    unless params[:neighborhood][:address] == ""
      @geocode = Geocoder.coordinates(params[:neighborhood][:address])
      @neighborhood.latitude = @geocode[0]
      @neighborhood.longitude = @geocode[1]
    end
    if @neighborhood.save
      redirect_to edit_neighborhood_path(@neighborhood), :notice => "Successfully created neighborhood."
    else
      render :action => 'new'
    end
  end

  def change
    @all = Neighborhood.all
    @neighborhoods = @all.map(&:name)
    render :update do |page|
	    page.replace_html "neighborhood", :partial => "neighborhoods/neighborhood"
	  end
  end
  
  def edit
    if user_signed_in?
      if current_user.role == "admin"
        @neighborhood = Neighborhood.find(params[:id])
        @zipcode = Zipcode.new
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end
  
  def poophole
    @neighborhood = Neighborhood.find_by_name(params[:neighborhood][:name])
    unless params[:neighborhood][:address] == ""
      @geocode = Geocoder.coordinates(params[:neighborhood][:address])
      @neighborhood.latitude = @geocode[0]
      @neighborhood.longitude = @geocode[1]
    end
    if @neighborhood.update_attributes(params[:neighborhood])
      redirect_to new_neighborhood_path, :notice => "Successfully updated neighborhood."
    else
      render :action => 'edit'
    end
  end

  def update
    @neighborhood = Neighborhood.find(params[:user][:neighborhood_id])
    current_user.neighborhood_id = @neighborhood.id
    current_user.save!
    redirect_to :controller => "neighborhoods", :action => "show", :id => @neighborhood.friendly_id
  end
  
  def update_signed_out
    session[:neighborhood] = params[:neighborhood_id]
    @neighborhood = Neighborhood.find session[:neighborhood]
    redirect_to :controller => "neighborhoods", :action => "show", :id => @neighborhood.friendly_id
  end

  def destroy
    @neighborhood = Neighborhood.find(params[:id])
    @neighborhood.destroy
    redirect_to new_neighborhood_path, :notice => "Successfully destroyed neighborhood."
  end
  
  def personalization
    render :update do |page|
      page.visual_effect :toggle_blind, 'personalizations'
      page.visual_effect :toggle_blind, 'personalizations_show'
    end
  end
  
  def map_toggle
    render :update do |page|
      page.visual_effect :toggle_blind, 'map_toggle'
      page.visual_effect :toggle_blind, 'map_show'
    end
  end
  
end
