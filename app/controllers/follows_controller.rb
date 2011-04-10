class FollowsController < ApplicationController
  def new
    @follow = Follow.create(:user_id => current_user.id, :business_id => params[:business_id])
    @business = Business.find params[:business_id]
    render :update do |page|
			page.replace_html "follow", "#{link_to "Unfollow #{@business.name}", follow_path(current_user.id, :business_id => @business.id), :method => :delete, :remote => true }"
	  end
  end

  def destroy
    @follow = Follow.find_by_user_id_and_business_id(current_user.id, params[:business_id])
    @follow.destroy
    @business = Business.find(params[:business_id])
    render :update do |page|
			page.replace_html "follow", "#{link_to "Follow #{@business.name}", new_follow_path(current_user.id, :business_id => @business.id), :remote => true }"
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
