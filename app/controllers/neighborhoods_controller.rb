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
    @zipcodes = @neighborhood.zipcodes
    @zipcode = @neighborhood.zipcodes.new
  end

  def new
    @neighborhood = Neighborhood.new
    @neighborhoods = Neighborhood.all
  end

  def create
    @neighborhood = Neighborhood.new(params[:neighborhood])
    if @neighborhood.save
      redirect_to @neighborhood, :notice => "Successfully created neighborhood."
    else
      render :action => 'new'
    end
  end

  def edit
    @all = Neighborhood.all
    @neighborhoods = @all.map(&:name)
    render :update do |page|
	    page.replace_html "neighborhood", :partial => "neighborhoods/neighborhood"
	  end
  end

  def update
    current_user.neighborhood_id = params[:user][:neighborhood_id]
    current_user.save!
    #if params[:controller] = "home" && params[:action] == "index"
      @user_categories = current_user.categories
      @user_subcategories = current_user.subcategories
      @results = Array.new
      @user_subcategories.each do |s|
        @search = Frugle.find :all, :include => :business, :conditions => [ "businesses.subcategory_id = ? AND businesses.neighborhood_id = ?", s.id, current_user.neighborhood_id]
        @results = @results | @search
      end
       @map = Variable.new("map")
        @markers = Array.new
        for frugle in @results
          @marker = GMarker.new([frugle.business.latitude,frugle.business.longitude],:title => "#{frugle.business.name}", :info_window => "#{frugle.business.name} <br /> #{frugle.business.address}<br />#{frugle.business.zip}<br />#{frugle.business.phone}")
          @markers << @marker
        end
      #end
      render :update do |page|
  	    page.replace_html "neighborhood", "#{current_user.neighborhood.name} #{link_to "(change)", edit_neighborhood_path, :remote => true}"
  	    #if params[:controller] = "home" && params[:action] == "index"
  	      page.replace_html "subcategories", :partial => 'home/subcategories', :user_categories => @user_categories
  	      page.replace_html "frugles", :partial => 'home/frugles', :results => @results
  	      page << @map.clear_overlays
  			  for marker in @markers
  			    page << @map.add_overlay(marker)
  	      end
	      #end
	    end
  end
  
  def update_signed_out
    session[:neighborhood] = params[:neighborhood_id]
    @neighborhood = Neighborhood.find session[:neighborhood]
      #if params[:controller] = "home" && params[:action] == "index"
      @results = Frugle.find :all, :include => :business, :conditions => [ "businesses.neighborhood_id = ?", session[:neighborhood]]
      @map = Variable.new("map")
        @markers = Array.new
        for frugle in @results
          @marker = GMarker.new([frugle.business.latitude,frugle.business.longitude],:title => "#{frugle.business.name}", :info_window => "#{frugle.business.name} <br /> #{frugle.business.address}<br />#{frugle.business.zip}<br />#{frugle.business.phone}")
          @markers << @marker
        end
      #end
    render :update do |page|
	    page.replace_html "neighborhood", "#{@neighborhood.name} #{link_to "(change)", edit_neighborhood_path(@neighborhood), :remote => true}"
	    #if params[:controller] = "home" && params[:action] == "index"
	      page.replace_html "frugles", :partial => 'home/frugles', :results => @results
	      page << @map.clear_overlays
			  for marker in @markers
			    page << @map.add_overlay(marker)
	      end
      #end
    end
  end

  def destroy
    @neighborhood = Neighborhood.find(params[:id])
    @neighborhood.destroy
    redirect_to neighborhoods_url, :notice => "Successfully destroyed neighborhood."
  end
end
