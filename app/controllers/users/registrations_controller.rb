class Users::RegistrationsController < Devise::RegistrationsController
  layout "splash", :only => :new

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
  
  def edit
    @interval_options = [['As It Happens', 'instant'], ['Daily', 'daily'], ['Weekly', 'weekly'], ['Monthly', 'monthly']]
    render :layout => "application"
  end
  
  def update
    super
    resource.neighborhood_id = params[:user][:neighborhood_id]
    resource.email_setting.newsletter = params[:user][:email_setting_attributes][:newsletter]
    resource.email_setting.new_frugles = params[:user][:email_setting_attributes][:new_frugles]
    resource.email_setting.interval = params[:user][:email_setting_attributes][:interval]
    resource.email_setting.businesses_following = params[:user][:email_setting_attributes][:businesses_following]
    resource.email_setting.categories_following = params[:user][:email_setting_attributes][:categories_following]
    resource.email_setting.recommendations = params[:user][:email_setting_attributes][:recommendations]
    resource.email_setting.save!
    resource.save!
  end

end