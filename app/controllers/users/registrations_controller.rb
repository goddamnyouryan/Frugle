class Users::RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(params[:user])
    @user.neighborhood_id = session[:neighborhood]
    if @user.save
      sign_in_and_redirect(:user, @user)
    else
      render :action => "new"
    end
  end

end