class FollowsController < ApplicationController
  def new
    @follow = Follow.create(:user_id => current_user.id, :business_id => params[:business_id])
    @business = Business.find params[:business_id]
    render :update do |page|
			page.replace_html "follow", :partial => "frugles/follow", :business => @business
	  end
  end

  def destroy
    @follow = Follow.find_by_user_id_and_business_id(current_user.id, params[:business_id])
    @follow.destroy
    @business = Business.find(params[:business_id])
    render :update do |page|
			page.replace_html "follow", :partial => "frugles/follow", :business => @business
	  end
  end
  
  def unfollow
    @follow = Follow.find_by_user_id_and_business_id(current_user.id, params[:business_id])
    @follow.destroy
    render :update do |page|
      page.replace_html "businesses_following", :partial => 'users/registrations/businesses_following'
    end
  end

end
