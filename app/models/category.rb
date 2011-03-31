class Category < ActiveRecord::Base
  attr_accessible :title
  
  has_many :subcategories
  
  has_many :categorizations
  has_many :users, :through => :categorizations
  
end
