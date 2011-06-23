class Rep < ActiveRecord::Base
  belongs_to :neighborhood
  
  attr_accessor :category_id, :subcategory_id
  
  validates_format_of :phone, :with => /^[2-9]\d{2}\.\d{3}\.\d{4}$/
end
