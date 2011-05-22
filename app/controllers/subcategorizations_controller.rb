class SubcategorizationsController < ApplicationController
  
  def new
    @subcategorization = Subcategorization.create(:user_id => current_user.id, :subcategory_id => params[:subcategory_id])
    @subcategory = Subcategory.find(params[:subcategory_id])
    @user_categories = current_user.categories
    @neighborhood = Neighborhood.find current_user.neighborhood_id
    @user_subcategories = current_user.subcategories
    @results = Frugle.paginate :all, :include => :business, :conditions => [ "frugles.subcategory_id IN (?) AND businesses.neighborhood_id = ?", @user_subcategories, current_user.neighborhood_id], :page => params[:page]
    @map = Variable.new("map")
    @markers = Array.new
    map_marker
    icon_variables
    for frugle in @results
      @marker = GMarker.new([frugle.business.latitude,frugle.business.longitude],:title => "#{frugle.business.name}", :info_window => "<a href=\"#{business_path(frugle.business)}\" style=\"font-weight:bold\">#{frugle.business.name}</a> <br /> #{frugle.business.address}<br />#{frugle.business.zip}<br />#{frugle.business.phone}<br /><a href=\"#{business_frugle_url(frugle.business, frugle)}\" style=\"font-weight:bold\" class=\"iframe\">View Frugle</a>", :icon => icon_name(frugle))
      @markers << @marker
    end
    respond_to do |format|
      format.html { redirect_to root_url }
    	format.js
    end
  end
  
  def out_new
    @session_id = request.session_options[:id]
    @neighborhood = Neighborhood.find session[:neighborhood]
    @user = User.find_by_logged_out("#{@session_id}")
    @subcategorization = Subcategorization.create(:user_id => @user.id, :subcategory_id => params[:subcategory_id])
    @subcategory = Subcategory.find(params[:subcategory_id])
    @user_categories = @user.categories
    @user_subcategories = @user.subcategories
    @results = Frugle.paginate :all, :include => :business, :conditions => [ "frugles.subcategory_id IN (?) AND businesses.neighborhood_id = ?", @user_subcategories, session[:neighborhood]], :page => params[:page]
    @map = Variable.new("map")
    @markers = Array.new
    map_marker
    icon_variables
    for frugle in @results
      @marker = GMarker.new([frugle.business.latitude,frugle.business.longitude],:title => "#{frugle.business.name}", :info_window => "<a href=\"#{business_path(frugle.business)}\" style=\"font-weight:bold\">#{frugle.business.name}</a> <br /> #{frugle.business.address}<br />#{frugle.business.zip}<br />#{frugle.business.phone}<br /><a href=\"#{business_frugle_url(frugle.business, frugle)}\" style=\"font-weight:bold\" class=\"iframe\">View Frugle</a>", :icon => icon_name(frugle))
      @markers << @marker
    end
    respond_to do |format|
      format.html { redirect_to root_url }
    	format.js
    end
  end
  
  def destroy
    @subcategorization = Subcategorization.find_by_user_id_and_subcategory_id(current_user.id, params[:subcategory_id])
    @subcategorization.destroy
    @subcategory = Subcategory.find(params[:subcategory_id])
    @neighborhood = Neighborhood.find current_user.neighborhood_id
    @user_categories = current_user.categories
    @user_subcategories = current_user.subcategories
    @results = Frugle.paginate :all, :include => :business, :conditions => [ "frugles.subcategory_id IN (?) AND businesses.neighborhood_id = ?", @user_subcategories, current_user.neighborhood_id], :page => params[:page]
    @map = Variable.new("map")
    @markers = Array.new
    map_marker
    icon_variables
    for frugle in @results
      @marker = GMarker.new([frugle.business.latitude,frugle.business.longitude],:title => "#{frugle.business.name}", :info_window => "<a href=\"#{business_path(frugle.business)}\" style=\"font-weight:bold\">#{frugle.business.name}</a> <br /> #{frugle.business.address}<br />#{frugle.business.zip}<br />#{frugle.business.phone}<br /><a href=\"#{business_frugle_url(frugle.business, frugle)}\" style=\"font-weight:bold\" class=\"iframe\">View Frugle</a>", :icon => icon_name(frugle))
      @markers << @marker
    end
    respond_to do |format|
      format.html { redirect_to root_url }
    	format.js
    end
  end
  
  def out_destroy
    @session_id = request.session_options[:id]
    @neighborhood = Neighborhood.find session[:neighborhood]
    @user = User.find_by_logged_out("#{@session_id}")
    @subcategorization = Subcategorization.find_by_user_id_and_subcategory_id(@user.id, params[:subcategory_id])
    @subcategorization.destroy
    @subcategory = Subcategory.find(params[:subcategory_id])
    @user_categories = @user.categories
    @user_subcategories = @user.subcategories
    @results = Frugle.paginate :all, :include => :business, :conditions => [ "frugles.subcategory_id IN (?) AND businesses.neighborhood_id = ?", @user_subcategories, session[:neighborhood]], :page => params[:page]
    @map = Variable.new("map")
    @markers = Array.new
    map_marker
    icon_variables
    for frugle in @results
      @marker = GMarker.new([frugle.business.latitude,frugle.business.longitude],:title => "#{frugle.business.name}", :info_window => "<a href=\"#{business_path(frugle.business)}\" style=\"font-weight:bold\">#{frugle.business.name}</a> <br /> #{frugle.business.address}<br />#{frugle.business.zip}<br />#{frugle.business.phone}<br /><a href=\"#{business_frugle_url(frugle.business, frugle)}\" style=\"font-weight:bold\" class=\"iframe\">View Frugle</a>", :icon => icon_name(frugle))
      @markers << @marker
    end
    respond_to do |format|
      format.html { redirect_to root_url }
    	format.js
    end
  end  
  
  def select_all
    @neighborhood = Neighborhood.find current_user.neighborhood_id
    @categories = current_user.categories
    @categories.each do |category|
      @businesses = Frugle.find :all, :include => :business, :conditions => ["frugles.category_id = ? AND businesses.neighborhood_id = ?", category.id, current_user.neighborhood_id]
      unless @businesses.empty?
        @subcategories = @businesses.map(&:subcategory).uniq - current_user.subcategories
        unless @subcategories == nil
          @subcategories.each do |s|
            @subcategorization = Subcategorization.create(:user_id => current_user.id, :subcategory_id => s.id)
          end
        end
      end
    end
    @user_categories = current_user.categories
    @user_subcategories = Subcategory.find :all, :include => :subcategorizations, :conditions => [ "subcategorizations.user_id = ?", current_user.id]
    @results = Frugle.paginate :all, :include => :business, :conditions => [ "frugles.subcategory_id IN (?) AND businesses.neighborhood_id = ?", @user_subcategories, current_user.neighborhood_id], :page => params[:page]
    @map = Variable.new("map")
    @markers = Array.new
    map_marker
    icon_variables
    for frugle in @results
      @marker = GMarker.new([frugle.business.latitude,frugle.business.longitude],:title => "#{frugle.business.name}", :info_window => "<a href=\"#{business_path(frugle.business)}\" style=\"font-weight:bold\">#{frugle.business.name}</a> <br /> #{frugle.business.address}<br />#{frugle.business.zip}<br />#{frugle.business.phone}<br /><a href=\"#{business_frugle_url(frugle.business, frugle)}\" style=\"font-weight:bold\" class=\"iframe\">View Frugle</a>", :icon => icon_name(frugle))
      @markers << @marker
    end
    respond_to do |format|
    	format.html { redirect_to root_url }
    	format.js
    end
  end
  
  def select_none
    @neighborhood = Neighborhood.find current_user.neighborhood_id
    @subcategorizations = current_user.subcategorizations
    @subcategories = @subcategorizations.map(&:subcategory).uniq
    current_user.subcategorizations.each do |subcategorization|
      subcategorization.destroy
    end
    @results = Array.new
    @map = Variable.new("map")
    respond_to do |format|
    	format.html { redirect_to root_url }
    	format.js
    end
  end
    
  def out_select_all
    @neighborhood = Neighborhood.find session[:neighborhood]
    @session_id = request.session_options[:id]
    @user = User.find_by_logged_out("#{@session_id}")
    @categories = @user.categories
    @categories.each do |category|
      @businesses = Frugle.find :all, :include => :business, :conditions => ["frugles.category_id = ? AND businesses.neighborhood_id = ?", category.id, session[:neighborhood]]
      unless @businesses.empty?
        @subcategories = @businesses.map(&:subcategory).uniq - @user.subcategories
        unless @subcategories == nil
          @subcategories.each do |s|
            @subcategorization = Subcategorization.create(:user_id => @user.id, :subcategory_id => s.id)
          end
        end
      end
    end
    @user_categories = @user.categories
    @user_subcategories = Subcategory.find :all, :include => :subcategorizations, :conditions => [ "subcategorizations.user_id = ?", @user.id]
    @results = Frugle.paginate :all, :include => :business, :conditions => [ "frugles.subcategory_id IN (?) AND businesses.neighborhood_id = ?", @user_subcategories, session[:neighborhood]], :page => params[:page]
    @map = Variable.new("map")
    @markers = Array.new
    map_marker
    icon_variables
    for frugle in @results
      @marker = GMarker.new([frugle.business.latitude,frugle.business.longitude],:title => "#{frugle.business.name}", :info_window => "<a href=\"#{business_path(frugle.business)}\" style=\"font-weight:bold\">#{frugle.business.name}</a> <br /> #{frugle.business.address}<br />#{frugle.business.zip}<br />#{frugle.business.phone}<br /><a href=\"#{business_frugle_url(frugle.business, frugle)}\" style=\"font-weight:bold\" class=\"iframe\">View Frugle</a>", :icon => icon_name(frugle))
      @markers << @marker
    end
    respond_to do |format|
    	format.html { redirect_to root_url }
    	format.js
    end
  end
  
  def out_select_none
    @neighborhood = Neighborhood.find session[:neighborhood]
    @session_id = request.session_options[:id]
    @user = User.find_by_logged_out("#{@session_id}")
    @subcategorizations = @user.subcategorizations
    @subcategories = @subcategorizations.map(&:subcategory).uniq
    @user.subcategorizations.each do |subcategorization|
      subcategorization.destroy
    end
    @results = Array.new
    @map = Variable.new("map")
    respond_to do |format|
    	format.html { redirect_to root_url }
    	format.js
    end
  end
  
end
