class SubcategorizationsController < ApplicationController
  
  def new
    if user_signed_in?
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
      render :update do |page|
		  	page.replace_html "subcategory_#{params[:subcategory_id]}", "#{link_to "#{@subcategory.title}", subcategorization_path(current_user.id, :subcategory_id => @subcategory.id), :method => :delete, :remote => true, :style => "background-color:yellow;"}"
		  	page.replace_html "frugles", :partial => 'neighborhoods/frugle', :collection => @results, :as => :frugle
		  	page << @map.clear_overlays
		  	for marker in @markers
		  	  page << @map.add_overlay(marker)
	      end
	    end
    else
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
      render :update do |page|
		  	page.replace_html "subcategory_#{params[:subcategory_id]}", "#{link_to "#{@subcategory.title}", subcategorization_path(@user.id, :subcategory_id => @subcategory.id), :method => :delete, :remote => true, :style => "background-color:yellow;"}"
		  	page.replace_html "frugles", :partial => 'neighborhoods/frugle', :collection => @results, :as => :frugle
		  	page << @map.clear_overlays
		  	for marker in @markers
		  	  page << @map.add_overlay(marker)
	      end
	    end
    end
  end
  
  def destroy
    if user_signed_in?
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
      render :update do |page|
		  	page.replace_html "subcategory_#{params[:subcategory_id]}", "#{link_to "#{@subcategory.title}", new_subcategorization_path(current_user.id, :subcategory_id => @subcategory.id), :remote => true, :style => "background-color:white;"}"
		  	page.replace_html "frugles", :partial => 'neighborhoods/frugle', :collection => @results, :as => :frugle
		  	page << @map.clear_overlays
		  	for marker in @markers
		  	  page << @map.add_overlay(marker)
	      end
	    end
    else
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
      render :update do |page|
		  	page.replace_html "subcategory_#{params[:subcategory_id]}", "#{link_to "#{@subcategory.title}", new_subcategorization_path(@user.id, :subcategory_id => @subcategory.id), :remote => true, :style => "background-color:white;"}"
		  	page.replace_html "frugles", :partial => 'neighborhoods/frugle', :collection => @results, :as => :frugle
		  	page << @map.clear_overlays
		  	for marker in @markers
		  	  page << @map.add_overlay(marker)
	      end
	    end
    end
  end
  
end
