class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "application"
  
  def map_marker
    @map.icon_global_init( GIcon.new(:image => "images/auto.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "auto")
    @map.icon_global_init( GIcon.new(:image => "images/bodyandbeauty.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "bodyandbeauty")
    @map.icon_global_init( GIcon.new(:image => "images/cleaning.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "cleaning")
    @map.icon_global_init( GIcon.new(:image => "images/entertainment.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "entertainment")
    @map.icon_global_init( GIcon.new(:image => "images/family.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "family")
    @map.icon_global_init( GIcon.new(:image => "images/financialservices.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "financialservices")
    @map.icon_global_init( GIcon.new(:image => "images/food.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "food")
    @map.icon_global_init( GIcon.new(:image => "images/health.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "health")
    @map.icon_global_init( GIcon.new(:image => "images/home.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "home")
    @map.icon_global_init( GIcon.new(:image => "images/nightlife.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "nightlife")
    @map.icon_global_init( GIcon.new(:image => "images/partiesandevents.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "partiesandevents")
    @map.icon_global_init( GIcon.new(:image => "images/pets.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "pets")
    @map.icon_global_init( GIcon.new(:image => "images/professionalservices.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "professionalservices")
    @map.icon_global_init( GIcon.new(:image => "images/restaurant.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "restaurants")
    @map.icon_global_init( GIcon.new(:image => "images/schooling.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "schooling")
    @map.icon_global_init( GIcon.new(:image => "images/shopping.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "shopping")
    @map.icon_global_init( GIcon.new(:image => "images/sports.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "sports")
    @map.icon_global_init( GIcon.new(:image => "images/travel.png",:icon_size => GSize.new(30,30),:icon_anchor => GPoint.new(9,32),:info_window_anchor => GPoint.new(9,2), :info_shadow_anchor => GPoint.new(18,25)), "travel")
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
    @shopping = Variable.new('shopping')
    @sports = Variable.new('sports')
    @travel = Variable.new('travel')
  end
  
  def icon_name(frugle)
    if frugle.business.category_id == 1
      @auto
    elsif frugle.business.category_id == 2
      @bodyandbeauty
    elsif frugle.business.category_id == 3
      @cleaning
    elsif frugle.business.category_id == 4
      @entertainment
    elsif frugle.business.category_id == 5
      @family
    elsif frugle.business.category_id == 6
      @financialservices
    elsif frugle.business.category_id == 7
      @food
    elsif frugle.business.category_id == 8
      @health
    elsif frugle.business.category_id == 9
      @home
    elsif frugle.business.category_id == 10
      @nightlife
    elsif frugle.business.category_id == 11
      @partiesandevents
    elsif frugle.business.category_id == 12
      @pets
    elsif frugle.business.category_id == 13
      @professionalservices
    elsif frugle.business.category_id == 14
      @restaurants
    elsif frugle.business.category_id == 15
      @schooling
    elsif frugle.business.category_id == 16
      @shopping
    elsif frugle.business.category_id == 17
      @sports
    elsif frugle.business.category_id == 18
      @travel
    else 
      @auto
    end
  end
    
end
