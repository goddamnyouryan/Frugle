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
    render :layout => "application"
  end

end