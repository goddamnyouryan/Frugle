class ApplicationController < ActionController::Base
  before_filter :check_uri
  protect_from_forgery
  layout "application"
  
  def check_uri
    redirect_to request.protocol + "www." + request.host_with_port + request.request_uri if !/^www/.match(request.host) if Rails.env == 'production'
  end
  
  def map_marker
    @map.icon_global_init( GIcon.new(:image => "images/icons/barsandclubs.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "auto")
    @map.icon_global_init( GIcon.new(:image => "images/icons/bodyandbeauty.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "bodyandbeauty")
    @map.icon_global_init( GIcon.new(:image => "images/icons/businessandprofessionalservic.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "cleaning")
    @map.icon_global_init( GIcon.new(:image => "images/icons/car.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "entertainment")
    @map.icon_global_init( GIcon.new(:image => "images/icons/cleanersandfixers.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "family")
    @map.icon_global_init( GIcon.new(:image => "images/icons/clothing.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "financialservices")
    @map.icon_global_init( GIcon.new(:image => "images/icons/foodandcafes.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "food")
    @map.icon_global_init( GIcon.new(:image => "images/icons/health.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "health")
    @map.icon_global_init( GIcon.new(:image => "images/icons/homeandoffice.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "home")
    @map.icon_global_init( GIcon.new(:image => "images/icons/partiesandfunevents.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "nightlife")
    @map.icon_global_init( GIcon.new(:image => "images/icons/pets.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "partiesandevents")
    @map.icon_global_init( GIcon.new(:image => "images/icons/placestogo.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "pets")
    @map.icon_global_init( GIcon.new(:image => "images/icons/restaurants.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "professionalservices")
    @map.icon_global_init( GIcon.new(:image => "images/icons/shopping.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "restaurants")
    @map.icon_global_init( GIcon.new(:image => "images/icons/travel.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "schooling")
  end
  
  def icon_variables
    @auto = Variable.new('auto')
    @bodyandbeauty = Variable.new('bodyandbeauty')
    @cleaning = Variable.new('cleaning')
    @entertainment = Variable.new('entertainment')
    @family = Variable.new('family')
    @financialservices = Variable.new('financialservices')
    @food = Variable.new('food')
    @health = Variable.new('health')
    @home = Variable.new('home')
    @nightlife = Variable.new('nightlife')
    @partiesandevents = Variable.new('partiesandevents')
    @pets = Variable.new('pets')
    @professionalservices = Variable.new('professionalservices')
    @restaurants = Variable.new('restaurants')
    @schooling = Variable.new('schooling')
  end
  
  def icon_name(frugle)
    if frugle.category_id == 1
      @auto
    elsif frugle.category_id == 2
      @bodyandbeauty
    elsif frugle.category_id == 3
      @cleaning
    elsif frugle.category_id == 4
      @entertainment
    elsif frugle.category_id == 5
      @family
    elsif frugle.category_id == 6
      @financialservices
    elsif frugle.category_id == 7
      @food
    elsif frugle.category_id == 8
      @health
    elsif frugle.category_id == 9
      @home
    elsif frugle.category_id == 10
      @nightlife
    elsif frugle.category_id == 11
      @partiesandevents
    elsif frugle.category_id == 12
      @pets
    elsif frugle.category_id == 13
      @professionalservices
    elsif frugle.category_id == 14
      @restaurants
    elsif frugle.category_id == 15
      @schooling
    else 
      @auto
    end
  end
    
end
