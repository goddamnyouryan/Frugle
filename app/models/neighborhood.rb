class Neighborhood < ActiveRecord::Base
  has_many :zipcodes
  has_many :users
  
  attr_accessible :name, :background
  
  attr_accessor :address, :background

  has_friendly_id :name, :use_slug => true
  
  geocoded_by :address
  after_validation :geocode 
  
  has_attached_file :background, :styles => { :full => "1440x900>" },
                    :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                    :path => ':id/:style', :bucket => "frugle_development"
end
