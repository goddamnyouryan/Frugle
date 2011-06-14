class Rep < ActiveRecord::Base
  belongs_to :neighborhood
  
  attr_accessor :category_id, :subcategory_id
end
