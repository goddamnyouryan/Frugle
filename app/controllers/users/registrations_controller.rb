class Users::RegistrationsController < Devise::RegistrationsController
  layout "splash", :only => [:new, :index ]
  
  def index
    redirect_to new_user_registration_path
  end

  def create
    @user = User.new(params[:user])
    @user.neighborhood_id = session[:neighborhood]
    if @user.save
      flash[:notice] = "Account successfully created. You are now logged in."
      sign_in_and_redirect(:user, @user)
    else
      redirect_to new_user_registration_path, :notice => "This email address is already registered. <a href='/users/password/new'>Forgot Password?</a>".html_safe
    end
  end
  
  def edit
    @interval_options = [['As It Happens', 'instant'], ['Daily', 'daily'], ['Weekly', 'weekly'], ['Monthly', 'monthly'], ['Never', 'never']]
    @facebook = UserToken.find_by_user_id(current_user.id)
    render :layout => "application"
  end
  
  def update
    unless resource.role == "business"
      super
      resource.neighborhood_id = params[:user][:neighborhood_id]
      resource.email_setting.newsletter = params[:user][:email_setting_attributes][:newsletter]
      resource.email_setting.businesses_following = params[:user][:email_setting_attributes][:businesses_following]
      resource.email_setting.categories_following = params[:user][:email_setting_attributes][:categories_following]
      resource.email_setting.recommendations = params[:user][:email_setting_attributes][:recommendations]
      resource.email_setting.save!
      resource.save!
    else
      super
      resource.save!
    end
  end
  
  protected
  
  def after_inactive_sign_up_path_for(resource)
    businesses_path
  end

end