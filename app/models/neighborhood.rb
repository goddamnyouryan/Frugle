class Neighborhood < ActiveRecord::Base
  has_many :zipcodes
  has_many :users
  
  attr_accessible :name

  has_friendly_id :name, :use_slug => true

end
