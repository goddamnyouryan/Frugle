class Users::RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(params[:user])
    @user.neighborhood_id = session[:neighborhood]
    if @user.save
      flash[:notice] = "Account successfully created. You are now logged in."
      sign_in_and_redirect(:user, @user)
    else
      render :action => "new"
    end
  end
  
  def update
    current_user.settings.newsletter = params[:user][:newsletter]
    current_user.settings.new_frugles = params[:user][:new_frugles]
    current_user.settings.businesses_following = params[:user][:businesses_following]
    current_user.settings.categories_following = params[:user][:categories_following]
    current_user.settings.recommendations = params[:user][:recommendations]
    if params[:user][:interval]
      current_user.settings.recommendations = params[:user][:interval]
    end
    super
  end

end