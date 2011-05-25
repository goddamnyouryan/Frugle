class Frugle < ActiveRecord::Base
  attr_accessible :business_id, :type, :details, :mobile, :quantity, :views, :start, :end, :verification, :status, :percentage, :product, :customers, :altered, :visit, :other_offer, :cost, :category_id, :subcategory_id, :discount
  
  cattr_reader :per_page
  @@per_page = 20
  
  belongs_to :business
  
  has_many :saveds
  has_many :users, :through => :saveds
  
  belongs_to :category
  belongs_to :subcategory
  
  acts_as_taggable
  
  before_validation :make_cost
  before_update :make_cost
  after_create :send_businesses_following_email, :send_category_following_email
  
  validates_presence_of :business_id, :type, :start, :end, :percentage, :product, :cost, :category_id, :subcategory_id, :discount
	
	def to_param
  		"#{id}-#{cost.slice(0..40).gsub(/\W/, '-').downcase.gsub(/-{2,}/,'-')}"
  end
  
  def send_businesses_following_email
    @users = User.find :all, :include => :email_setting, :conditions => ["email_settings.businesses_following = ?", "instant" ]
    @users.each do |user|
      if user.businesses.include?(self.business)
        FrugleMailer.instant_businesses_following(self, user).deliver
      end
    end
  end
  
  def make_cost
    if self.discount == "percent"
      self.cost = [percentage, product].join("% Off ")
    elsif self.discount == "dollar"
      self.cost = ["$#{percentage}", product].join(" Off ")
    elsif self.discount == "flat"
      self.cost = "$#{percentage} For #{product}"
    elsif self.discount == "bonus"
      self.cost = "Free #{percentage} With Purchase Of #{product}"
    elsif self.discount == "bogo"
      self.cost = "Buy One #{percentage} Get One #{product} Free"
    end
  end
  
  def send_category_following_email
    @users = User.find :all, :include => :email_setting, :conditions => ["email_settings.categories_following = ?", "instant" ]
    @users.each do |user|
      if user.categories.include?(self.category)
        FrugleMailer.instant_categories_following(self, user).deliver
      end
    end
  end
  
  
end
