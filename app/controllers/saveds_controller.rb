class SavedsController < ApplicationController
  
  def new
    @follow = Saved.create(:user_id => current_user.id, :frugle_id => params[:frugle_id])
    @frugle = Frugle.find params[:frugle_id]
    render :update do |page|
      page.select(".save_#{@frugle.id}").each do |element| 
        page.replace_html element, :partial => 'frugles/save', :frugle => @frugle
	    end
	  end
  end

  def destroy
    @save = Saved.find_by_user_id_and_frugle_id(current_user.id, params[:frugle_id])
    @save.destroy
    @frugle = Frugle.find(params[:frugle_id])
    render :update do |page|
      page.select(".save_#{@frugle.id}").each do |element| 
			  page.replace_html element, :partial => 'frugles/save', :frugle => @frugle
		  end
	  end
  end

end