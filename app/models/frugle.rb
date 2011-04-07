class Frugle < ActiveRecord::Base
  attr_accessible :business_id, :type, :details, :mobile, :quantity, :views, :start, :end, :verification, :status
  
  belongs_to :business
  
  has_many :saveds
  has_many :users, :through => :saveds
  
  attr_writer :percentage, :product

  before_save :create_discount

  def percentage
    @percentage.nil? ? discount.to_s.split('% Off ').first : @percentage
  end

  def product
    @product.nil? ? discount.to_s.split('% Off ').last : @product
  end

  protected

  def create_discount
    self.cost = "#{@percentage}% Off #{@product}" unless @product.nil? || @percentage.nil?
  end
  
end
