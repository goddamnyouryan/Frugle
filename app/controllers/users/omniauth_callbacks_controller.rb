class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def method_missing(provider)
    if !User.omniauth_providers.index(provider).nil?
      #omniauth = request.env["omniauth.auth"]
      omniauth = env["omniauth.auth"]
    
      if current_user #or User.find_by_email(auth.recursive_find_by_key("email"))
        current_user.user_tokens.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
         flash[:notice] = "Authentication successful"
         redirect_to edit_user_registration_path
      else
      @provider = omniauth.recursive_find_by_key('provider')
      @uid = omniauth.recursive_find_by_key('uid')
      authentication = UserToken.find_by_provider_and_uid(@provider, @uid)
        if authentication
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
          sign_in_and_redirect(:user, authentication.user)
          #sign_in_and_redirect(authentication.user, :event => :authentication)
        else
          #create a new user
          unless omniauth.recursive_find_by_key("email").blank?
            user = User.find_or_initialize_by_email(:email => omniauth.recursive_find_by_key("email"))
            if session[:neighborhood]
              user.neighborhood_id = session[:neighborhood]
            end
            user.first_name = omniauth.recursive_find_by_key("first_name")
            user.last_name = omniauth.recursive_find_by_key("last_name")
            user.password = "facebook"
            user.password_confirmation = "facebook"
            user.sex = "male"
            user.birthday = Date.today
          else
            user = User.new
          end
          user.apply_omniauth(omniauth)
          #user.confirm! #unless user.email.blank?

          if user.save
            flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider'] 
            sign_in_and_redirect(:user, user)
          else
            session[:omniauth] = omniauth.except('extra')
            redirect_to new_user_registration_url, :notice => "Something went wrong!"
          end
        end
      end
    end
  end
  
end