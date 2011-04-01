class Frugle < ActiveRecord::Base
  attr_accessible :business_id, :type, :details, :mobile, :quantity, :views, :start, :end, :verification, :status
  
  belongs_to :business
end
