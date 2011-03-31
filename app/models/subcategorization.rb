class Subcategorization < ActiveRecord::Base
  belongs_to :subcategory
  belongs_to :user
end
