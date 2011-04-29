class User < ActiveRecord::Base
  has_many :user_tokens
  belongs_to :neighborhood
  has_many :follows
  has_one :business
  has_many :businesses, :through => :follows
  
  has_many :categorizations
  has_many :categories, :through => :categorizations
  
  has_many :subcategorizations
  has_many :subcategories, :through => :subcategorizations
  
  has_many :saveds
  has_many :frugles, :through => :saveds
  has_one :email_setting
  accepts_nested_attributes_for :email_setting, :allow_destroy => true
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :sex, :birthday, :role
  
  attr_accessor :newsletter, :new_frugles, :businesses_following, :categories_following, :recommendations, :interval, :terms
  
  after_create :create_email_setting
  
  def create_email_setting
    unless self.role == "business"
      EmailSetting.create(:user_id => self.id, :newsletter => 1)
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session[:omniauth]
        user.user_tokens.build(:provider => data['provider'], :uid => data['uid'])
      end
    end
  end
  
  def apply_omniauth(omniauth)
    #add some info about the user
    #self.name = omniauth['user_info']['name'] if name.blank?
    #self.nickname = omniauth['user_info']['nickname'] if nickname.blank?
    
    unless omniauth['credentials'].blank?
      user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
      #user_tokens.build(:provider => omniauth['provider'], 
      #                  :uid => omniauth['uid'],
      #                  :token => omniauth['credentials']['token'], 
      #                  :secret => omniauth['credentials']['secret'])
    else
      user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
    end
    #self.confirm!# unless user.email.blank?
  end
  
  def password_required?
    (user_tokens.empty? || !password.blank?) && super  
  end
  
  def update_with_password(params={})
    if params[:password].blank? 
      params.delete(:password) 
      params.delete(:password_confirmation) if params[:password_confirmation].blank? 
    end 
    update_attributes(params) 
  end
  
  
  
end
