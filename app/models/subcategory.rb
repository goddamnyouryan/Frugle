class Subcategory < ActiveRecord::Base
  attr_accessible :category_id, :title
  
  belongs_to :category
  has_many :businesses
  has_many :frugles
  
  has_many :subcategorizations
  has_many :users, :through => :subcategorizations
end
