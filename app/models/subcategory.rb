class Subcategory < ActiveRecord::Base
  attr_accessible :category_id, :title
  
  belongs_to :category
end
