class Frugle < ActiveRecord::Base
  attr_accessible :business_id, :type, :details, :mobile, :quantity, :views, :start, :end, :verification, :status, :percentage, :product
  
  belongs_to :business
  
  has_many :saveds
  has_many :users, :through => :saveds
  
  def to_param
		"#{id}-#{cost.gsub(/\W/, '-').downcase}"
	end
end
