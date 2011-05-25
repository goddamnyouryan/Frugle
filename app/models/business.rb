class Business < ActiveRecord::Base
  belongs_to :category
  belongs_to :subcategory
  has_many :frugles, :dependent => :destroy
  has_many :follows
  
  belongs_to :user
  belongs_to :neighborhood
  attr_accessible :name, :address, :zip, :phone, :website, :info, :category_id, :subcategory_id, :hear_about, :contact_name, :contact_number, :role, :terms, :latitude, :longitude, :subcategory_name, :neighborhood_id
  
  attr_accessor :area_code, :first_three_digits, :second_four_digits, :terms
  
  validates_format_of :phone,
                      :message => "must be a valid telephone number.",
                      :with => /^[\(\)0-9\- \+\.]{10,20}$/
                      
  validates_presence_of :phone, :on => :create                   
                      
  geocoded_by :full_address
  after_validation :geocode
  after_update :send_welcome_email
  
  def send_welcome_email
    FrugleMailer.new_merchant_registration(self).deliver
  end
  
	def to_param
    "#{id}-#{name.slice(0..40).gsub(/\W/, '-').downcase.gsub(/-{2,}/,'-')}"
  end

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
