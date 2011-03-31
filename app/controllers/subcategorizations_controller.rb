class SubcategorizationsController < ApplicationController
  
  def new
    @subcategorization = Subcategorization.create(:user_id => current_user.id, :subcategory_id => params[:subcategory_id])
    @subcategory = Subcategory.find(params[:subcategory_id])
    render :update do |page|
			page.replace_html "subcategory_#{params[:subcategory_id]}", "#{link_to "#{@subcategory.title}", subcategorization_path(current_user.id, :subcategory_id => @subcategory.id), :method => :delete, :remote => true, :style => "background-color:yellow;"}"
	  end
  end
  
  def destroy
    @subcategorization = Subcategorization.find_by_user_id_and_subcategory_id(current_user.id, params[:subcategory_id])
    @subcategorization.destroy
    @subcategory = Subcategory.find(params[:subcategory_id])
    render :update do |page|
			page.replace_html "subcategory_#{params[:subcategory_id]}", "#{link_to "#{@subcategory.title}", new_subcategorization_path(current_user.id, :subcategory_id => @subcategory.id), :remote => true, :style => "background-color:white;"}"
	  end
  end
  
end
