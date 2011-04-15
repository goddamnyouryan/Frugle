class CategorizationsController < ApplicationController
  
  def new
    if user_signed_in?
      @category = Category.find(params[:category_id])
      @categorization = Categorization.create(:user_id => current_user.id, :category_id => params[:category_id])
      @businesses = Business.find :all, :include => :frugles, :conditions => ["businesses.category_id = ? AND neighborhood_id = ? AND frugles.id IS NOT NULL", @category.id, current_user.neighborhood_id]
      unless @businesses.empty?
        @subcategories = @businesses.map(&:subcategory).uniq
        @subcategories.each do |s|
            @subcategorization = Subcategorization.create(:user_id => current_user.id, :subcategory_id => s.id)
        end
      end
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
		  	page.replace_html "category_#{params[:category_id]}", "#{link_to @category.title, categorization_path(:category_id => @category.id), :method => :delete, :remote => true, :style => "background-color:yellow;"}"
	      page.replace_html "subcategories", :partial => 'neighborhoods/subcategories', :user_categories => @user_categories
	      page.replace_html "frugles", :partial => 'neighborhoods/frugle', :collection => @results, :as => :frugle
	      page << @map.clear_overlays
		  	for marker in @markers
		  	  page << @map.add_overlay(marker)
	      end
	    end
    else
      @session_id = request.session_options[:id]
      @user = User.find_by_logged_out("#{@session_id}")
      @category = Category.find(params[:category_id])
      @categorization = Categorization.create(:user_id => @user.id, :category_id => params[:category_id])
      @businesses = Business.find :all, :include => :frugles, :conditions => ["businesses.category_id = ? AND neighborhood_id = ? AND frugles.id IS NOT NULL", @category.id, session[:neighborhood]]
      unless @businesses.empty?
      @subcategories = @businesses.map(&:subcategory).uniq
      @subcategories.each do |s|
          @subcategorization = Subcategorization.create(:user_id => @user.id, :subcategory_id => s.id)
      end
      end
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
		  	page.replace_html "category_#{params[:category_id]}", "#{link_to @category.title, categorization_path(:category_id => @category.id), :method => :delete, :remote => true, :style => "background-color:yellow;"}"
	      page.replace_html "subcategories", :partial => 'neighborhoods/subcategories', :user_categories => @user_categories
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
      @categorization = Categorization.find_by_user_id_and_category_id(current_user.id, params[:category_id])
      @categorization.destroy
      @category = Category.find(params[:category_id])
      @businesses = Business.find :all, :include => :frugles, :conditions => ["businesses.category_id = ? AND frugles.id IS NOT NULL", @category.id]
      @subcategories = @businesses.map(&:subcategory).uniq
      @subcategories.each do |s|
          @subcategorization = Subcategorization.find_by_user_id_and_subcategory_id(current_user.id, s.id)
          unless @subcategorization == nil
            @subcategorization.destroy
          end
      end
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
		  	page.replace_html "category_#{params[:category_id]}", "#{link_to @category.title, new_categorization_path(:category_id => @category.id), :remote => true, :style => "background-color:white;"}"
	      page.replace_html "subcategories", :partial => 'neighborhoods/subcategories', :user_categories => @user_categories
	      page.replace_html "frugles", :partial => 'neighborhoods/frugle', :collection => @results, :as => :frugle
	      page << @map.clear_overlays
		  	for marker in @markers
		  	  page << @map.add_overlay(marker)
	      end
	    end
    else
      @session_id = request.session_options[:id]
      @user = User.find_by_logged_out("#{@session_id}")
      @categorization = Categorization.find_by_user_id_and_category_id(@user.id, params[:category_id])
      @categorization.destroy
      @category = Category.find(params[:category_id])
      @businesses = Business.find :all, :include => :frugles, :conditions => ["businesses.category_id = ? AND frugles.id IS NOT NULL", @category.id]
      @subcategories = @businesses.map(&:subcategory).uniq
      @subcategories.each do |s|
          @subcategorization = Subcategorization.find_by_user_id_and_subcategory_id(@user.id, s.id)
          unless @subcategorization == nil
            @subcategorization.destroy
          end
      end
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
		  	page.replace_html "category_#{params[:category_id]}", "#{link_to @category.title, new_categorization_path(:category_id => @category.id), :remote => true, :style => "background-color:white;"}"
	      page.replace_html "subcategories", :partial => 'neighborhoods/subcategories', :user_categories => @user_categories
	      page.replace_html "frugles", :partial => 'neighborhoods/frugle', :collection => @results, :as => :frugle
	      page << @map.clear_overlays
		  	for marker in @markers
		  	  page << @map.add_overlay(marker)
	      end
	    end
	  end 
  end
  
  def unfollow
    @categorization = Categorization.find_by_user_id_and_category_id(current_user.id, params[:category_id])
    @categorization.destroy
    render :update do |page|
      page.replace_html "categories_following", :partial => 'users/registrations/categories_following'
    end
  end
  
end
