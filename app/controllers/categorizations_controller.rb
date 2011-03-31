class CategorizationsController < ApplicationController
  
  def new
    @categorization = Categorization.create(:user_id => current_user.id, :category_id => params[:category_id])
    @category = Category.find(params[:category_id])
    @user_categories = current_user.categories
    render :update do |page|
			page.replace_html "category_#{params[:category_id]}", "#{link_to "#{@category.title}", categorization_path(current_user.id, :category_id => @category.id), :method => :delete, :remote => true, :style => "background-color:yellow;"}"
	    page.replace_html "subcategories", :partial => 'home/subcategories', :user_categories => @user_categories
	  end
  end
  
  def destroy
    @categorization = Categorization.find_by_user_id_and_category_id(current_user.id, params[:category_id])
    @categorization.destroy
    @category = Category.find(params[:category_id])
    @user_categories = current_user.categories
    render :update do |page|
			page.replace_html "category_#{params[:category_id]}", "#{link_to "#{@category.title}", new_categorization_path(current_user.id, :category_id => @category.id), :remote => true, :style => "background-color:white;"}"
	    page.replace_html "subcategories", :partial => 'home/subcategories', :user_categories => @user_categories
	  end
  end
  
end
