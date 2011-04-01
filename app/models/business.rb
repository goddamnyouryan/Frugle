class Business < ActiveRecord::Base
  belongs_to :category
  belongs_to :subcategory
  has_many :frugles
  
  belongs_to :user
  attr_accessible :name, :address, :zip, :phone, :website, :info
  
  def email
    user.email if user
  end
  
  def password
    user.password if user
  end
  
  def password_confirmation
    user.password_confirmation if user
  end
  
end
