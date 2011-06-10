class Zipcode < ActiveRecord::Base
  belongs_to :neighborhood
  has_many :assignments
  has_many :users, :through => :assignments
  attr_accessible :zip
end
