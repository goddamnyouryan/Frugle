class HomeController < ApplicationController
  
  def index
    @categories = Category.find :all, :order => "title ASC"
    @user_categories = current_user.categories
  end

end
