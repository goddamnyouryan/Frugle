class Frugle < ActiveRecord::Base
  attr_accessible :business_id, :type, :details, :mobile, :quantity, :views, :start, :end, :verification, :status, :percentage, :product, :customers, :altered, :visit, :other_offer
  
  belongs_to :business
  
  has_many :saveds
  has_many :users, :through => :saveds
  
  acts_as_taggable
	
	def to_param
  		"#{id}-#{cost.slice(0..40).gsub(/\W/, '-').downcase.gsub(/-{2,}/,'-')}"
  	end
end
