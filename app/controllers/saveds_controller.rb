class SavedsController < ApplicationController
  
  def new
    @frugle = Frugle.find params[:frugle_id]
    if user_signed_in?
      @follow = Saved.create(:user_id => current_user.id, :frugle_id => params[:frugle_id])
      render :update do |page|
        page.select(".save_#{@frugle.id}").each do |element| 
          page.replace_html element, :partial => 'frugles/save', :frugle => @frugle
	      end
	    end
    else
      session[:user_return_to] = business_path(@frugle.business)
      redirect_to new_user_session_path, :notice => "You need to be logged in to do that"
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