class Neighborhood < ActiveRecord::Base
  has_many :zipcodes
  has_many :users
  
  attr_accessible :name
  
  attr_accessor :address

  has_friendly_id :name, :use_slug => true
  
  geocoded_by :address
  after_validation :geocode 
  
end
