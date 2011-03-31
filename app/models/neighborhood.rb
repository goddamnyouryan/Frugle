class Neighborhood < ActiveRecord::Base
  has_many :zipcodes
  has_many :users
  
  attr_accessible :name
end
