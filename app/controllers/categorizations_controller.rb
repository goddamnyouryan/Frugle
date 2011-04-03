class CategorizationsController < ApplicationController
  
  def new
    @category = Category.find(params[:category_id])
    @categorization = Categorization.create(:user_id => current_user.id, :category_id => params[:category_id])
    @businesses = Business.find :all, :include => :frugles, :conditions => ["category_id = ? AND neighborhood_id = ? AND frugles.id IS NOT NULL", @category.id, current_user.neighborhood_id]
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
    render :update do |page|
			page.replace_html "category_#{params[:category_id]}", "#{link_to "#{@category.title}", categorization_path(current_user.id, :category_id => @category.id), :method => :delete, :remote => true, :style => "background-color:yellow;"}"
	    page.replace_html "subcategories", :partial => 'home/subcategories', :user_categories => @user_categories
	    page.replace_html "frugles", :partial => 'home/frugles', :results => @results
	  end
  end
  
  def destroy
    @categorization = Categorization.find_by_user_id_and_category_id(current_user.id, params[:category_id])
    @categorization.destroy
    @category = Category.find(params[:category_id])
    @businesses = Business.find :all, :include => :frugles, :conditions => ["category_id = ? AND frugles.id IS NOT NULL", @category.id]
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
    render :update do |page|
			page.replace_html "category_#{params[:category_id]}", "#{link_to "#{@category.title}", new_categorization_path(current_user.id, :category_id => @category.id), :remote => true, :style => "background-color:white;"}"
	    page.replace_html "subcategories", :partial => 'home/subcategories', :user_categories => @user_categories
	    page.replace_html "frugles", :partial => 'home/frugles', :results => @results
	  end
  end
  
end
