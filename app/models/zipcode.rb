class Zipcode < ActiveRecord::Base
  belongs_to :neighborhood
  
  attr_accessible :zip
end
