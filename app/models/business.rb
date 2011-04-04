class Business < ActiveRecord::Base
  belongs_to :category
  belongs_to :subcategory
  has_many :frugles
  has_many :follows
  
  belongs_to :user
  attr_accessible :name, :address, :zip, :phone, :website, :info
  
  attr_accessor :area_code, :first_three_digits, :second_four_digits
  
  validates_format_of :phone,
                      :message => "must be a valid telephone number.",
                      :with => /^[\(\)0-9\- \+\.]{10,20}$/
                      
  geocoded_by :full_address
  after_validation :geocode

  def full_address
    [address, zip].compact.join(', ')
  end

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
