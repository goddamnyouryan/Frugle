class SavedsController < ApplicationController
  def new
    @follow = Saved.create(:user_id => current_user.id, :frugle_id => params[:frugle_id])
    @frugle = Frugle.find params[:frugle_id]
    render :update do |page|
			page.replace_html "save", "#{link_to "Unsave this Frugle", saveds_path(current_user.id, :frugle_id => @frugle.id), :method => :delete, :remote => true }"
	  end
  end

  def destroy
    @save = Saved.find_by_user_id_and_frugle_id(current_user.id, params[:frugle_id])
    @save.destroy
    @frugle = Frugle.find(params[:frugle_id])
    render :update do |page|
			page.replace_html "save", "#{link_to "Save this Frugle", new_saveds_path(current_user.id, :frugle_id => @frugle.id), :remote => true }"
	  end
  end

end