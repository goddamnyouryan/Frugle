class SubcategorizationsController < ApplicationController
  
  def new
    @subcategorization = Subcategorization.create(:user_id => current_user.id, :subcategory_id => params[:subcategory_id])
    @subcategory = Subcategory.find(params[:subcategory_id])
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
    respond_to do |format|
      format.html { redirect_to root_url }
    	format.js
    end
  end
  
  def out_new
    @session_id = request.session_options[:id]
    @user = User.find_by_logged_out("#{@session_id}")
    @subcategorization = Subcategorization.create(:user_id => @user.id, :subcategory_id => params[:subcategory_id])
    @subcategory = Subcategory.find(params[:subcategory_id])
    @user_categories = @user.categories
    @user_subcategories = @user.subcategories
    @results = Array.new
    @user_subcategories.each do |s|
      @search = Frugle.find :all, :include => :business, :conditions => [ "businesses.subcategory_id = ? AND businesses.neighborhood_id = ?", s.id, session[:neighborhood]]
      @results = @results | @search
    end
    @map = Variable.new("map")
    @markers = Array.new
    for frugle in @results
      @marker = GMarker.new([frugle.business.latitude,frugle.business.longitude],:title => "#{frugle.business.name}", :info_window => "#{frugle.business.name} <br /> #{frugle.business.address}<br />#{frugle.business.zip}<br />#{frugle.business.phone}")
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
    respond_to do |format|
      format.html { redirect_to root_url }
    	format.js
    end
  end
  
  def out_destroy
    @session_id = request.session_options[:id]
    @user = User.find_by_logged_out("#{@session_id}")
    @subcategorization = Subcategorization.find_by_user_id_and_subcategory_id(@user.id, params[:subcategory_id])
    @subcategorization.destroy
    @subcategory = Subcategory.find(params[:subcategory_id])
    @user_categories = @user.categories
    @user_subcategories = @user.subcategories
    @results = Array.new
    @user_subcategories.each do |s|
      @search = Frugle.find :all, :include => :business, :conditions => [ "businesses.subcategory_id = ? AND businesses.neighborhood_id = ?", s.id, session[:neighborhood]]
      @results = @results | @search
    end
    @map = Variable.new("map")
    @markers = Array.new
    for frugle in @results
      @marker = GMarker.new([frugle.business.latitude,frugle.business.longitude],:title => "#{frugle.business.name}", :info_window => "#{frugle.business.name} <br /> #{frugle.business.address}<br />#{frugle.business.zip}<br />#{frugle.business.phone}")
      @markers << @marker
    end
    respond_to do |format|
      format.html { redirect_to root_url }
    	format.js
    end
  end  
  
end
