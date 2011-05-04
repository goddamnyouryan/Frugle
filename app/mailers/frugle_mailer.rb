class FrugleMailer < ActionMailer::Base
  default :from => "no-reply@frugle.me"
  
  def instant_businesses_following(frugle, user)
    @user = user
    @frugle = frugle
    @business = frugle.business
    mail(:to => "#{user.first_name} <#{user.email}>",
         :subject => "New Frugle from #{frugle.business.name}!", :from => "Frugle")
  end
  
  def instant_categories_following(frugle, user)
    @user = user
    @frugle = frugle
    @category = frugle.category
    mail(:to => "#{user.first_name} <#{user.email}>",
         :subject => "New #{@category.title} Frugle!", :from => "Frugle")
  end
  
  def new_user_registration(user)
      @user = user
      mail(:to => "#{user.first_name} <#{user.email}>",
           :subject => "Welcome to Frugle, #{user.first_name}!", :from => "Frugle")
  end
  
  def new_merchant_registration(business)
        @user = business.user
        mail(:to => "#{business.name} <#{business.user.email}>",
             :subject => "Welcome to Frugle, #{business.name}!", :from => "Frugle")
  end
  
  def send_contact_message(name, email, subject, message)
    @name = name
    @email = email
    @message = message
    mail(:to => "Taylor Ballenger <taylor@frugle.me>",
         :subject => "Frugle contact form message - #{subject}", :from => "Frugle")
  end
  
end
