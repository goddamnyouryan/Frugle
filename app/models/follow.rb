class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to :business
end
