module ApplicationHelper
  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end
  
  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files) }
  end
  
  def category_icon(frugle)
    if frugle.category_id == 1
      link_to image_tag('icons/barsandclubs.png'), business_frugle_path(frugle.business, frugle, :iframe => "true"), :class => 'iframe'
    elsif frugle.category_id == 2
      link_to image_tag('icons/bodyandbeauty.png'), business_frugle_path(frugle.business, frugle, :iframe => "true"), :class => 'iframe'
    elsif frugle.category_id == 3
      link_to image_tag('icons/businessandprofessionalservic.png'), business_frugle_path(frugle.business, frugle, :iframe => "true"), :class => 'iframe'
    elsif frugle.category_id == 4
      link_to image_tag('icons/car.png'), business_frugle_path(frugle.business, frugle, :iframe => "true"), :class => 'iframe'
    elsif frugle.category_id == 5
      link_to image_tag('icons/cleanersandfixers.png'), business_frugle_path(frugle.business, frugle, :iframe => "true"), :class => 'iframe'
    elsif frugle.category_id == 6
      link_to image_tag('icons/clothing.png'), business_frugle_path(frugle.business, frugle, :iframe => "true"), :class => 'iframe'
    elsif frugle.category_id == 7
      link_to image_tag('icons/foodandcafes.png'), business_frugle_path(frugle.business, frugle, :iframe => "true"), :class => 'iframe'
    elsif frugle.category_id == 8
      link_to image_tag('icons/health.png'), business_frugle_path(frugle.business, frugle, :iframe => "true"), :class => 'iframe'
    elsif frugle.category_id == 9
      link_to image_tag('icons/homeandoffice.png'), business_frugle_path(frugle.business, frugle, :iframe => "true"), :class => 'iframe'
    elsif frugle.category_id == 10
      link_to image_tag('icons/partiesandfunevents.png'), business_frugle_path(frugle.business, frugle, :iframe => "true"), :class => 'iframe'
    elsif frugle.category_id == 11
      link_to image_tag('icons/pets.png'), business_frugle_path(frugle.business, frugle, :iframe => "true"), :class => 'iframe'
    elsif frugle.category_id == 12
      link_to image_tag('icons/placestogo.png'), business_frugle_path(frugle.business, frugle, :iframe => "true"), :class => 'iframe'
    elsif frugle.category_id == 13
      link_to image_tag('icons/restaurants.png'), business_frugle_path(frugle.business, frugle, :iframe => "true"), :class => 'iframe'
    elsif frugle.category_id == 14
      link_to image_tag('icons/shopping.png'), business_frugle_path(frugle.business, frugle, :iframe => "true"), :class => 'iframe'
    elsif frugle.category_id == 15
      link_to image_tag('icons/travel.png'), business_frugle_path(frugle.business, frugle, :iframe => "true"), :class => 'iframe'
    else
      link_to image_tag('icons/barsandclubs.png'), business_frugle_path(frugle.business, frugle, :iframe => "true"), :class => 'iframe'
    end
  end
  
  def category_icon_business(business)
    if business.category_id == 1
      image_tag('auto.png')
    elsif business.category_id == 2
      image_tag('bodyandbeauty.png')
    elsif business.category_id == 3
      image_tag('cleaning.png')
    elsif business.category_id == 4
      image_tag('entertainment.png')
    elsif business.category_id == 5
      image_tag('family.png')
    elsif business.category_id == 6
      image_tag('financialservices.png')
    elsif business.category_id == 7
      image_tag('food.png')
    elsif business.category_id == 8
      image_tag('health.png')
    elsif business.category_id == 9
      image_tag('home.png')
    elsif business.category_id == 10
      image_tag('nightlife.png')
    elsif business.category_id == 11
      image_tag('partiesandevents.png')
    elsif business.category_id == 12
      image_tag('pets.png')
    elsif business.category_id == 13
      image_tag('professionalservices.png')
    elsif business.category_id == 14
      image_tag('restaurant.png')
    elsif business.category_id == 15
      image_tag('schooling.png')
    elsif business.category_id == 16
      image_tag('shopping.png')
    elsif business.category_id == 17
      image_tag('sports.png')
    elsif business.category_id == 18
      image_tag('travel.png')
    else
      image_tag('auto.png')
    end
  end
  
  def category_icon_nolink(frugle)
    if frugle.category_id == 1
      image_tag('icons/barsandclubs.png')
    elsif frugle.category_id == 2
      image_tag('icons/bodyandbeauty.png')
    elsif frugle.category_id == 3
      image_tag('icons/businessandprofessionalservic.png')
    elsif frugle.category_id == 4
      image_tag('icons/car.png')
    elsif frugle.category_id == 5
      image_tag('icons/cleanersandfixers.png')
    elsif frugle.category_id == 6
      image_tag('icons/clothing.png')
    elsif frugle.category_id == 7
      image_tag('icons/foodandcafes.png')
    elsif frugle.category_id == 8
      image_tag('icons/health.png')
    elsif frugle.category_id == 9
      image_tag('icons/homeandoffice.png')
    elsif frugle.category_id == 10
      image_tag('icons/partiesandfunevents.png')
    elsif frugle.category_id == 11
      image_tag('icons/pets.png')
    elsif frugle.category_id == 12
      image_tag('icons/placestogo.png')
    elsif frugle.category_id == 13
      image_tag('icons/restaurants.png')
    elsif frugle.category_id == 14
      image_tag('icons/shopping.png')
    elsif frugle.category_id == 15
      image_tag('icons/travel.png')
    else
      image_tag('icons/barsandclubs.png')
    end
  end
  
  def couponmap_category(business)
    if business.frugles.first.nil? || business.frugles.first.category_id.nil?
      "Other"
    elsif business.frugles.first.category_id == 1
      "Restaurants"
    elsif business.frugles.first.category_id == 2
      "Health & Beauty"
    elsif business.frugles.first.category_id == 3
      "Finance"
    elsif business.frugles.first.category_id == 4
      "Tools & Automotive"
    elsif business.frugles.first.category_id == 5
      "Home & Garden"
    elsif business.frugles.first.category_id == 6
      "Apparel"
    elsif business.frugles.first.category_id == 7
      "Restaurants"
    elsif business.frugles.first.category_id == 8
      "Health & Beauty"
    elsif business.frugles.first.category_id == 9
      "Office Supplies"
    elsif business.frugles.first.category_id == 10
      "Events"
    elsif business.frugles.first.category_id == 11
      "Pet Supplies"
    elsif business.frugles.first.category_id == 12
      "Sports & Recreation"
    elsif business.frugles.first.category_id == 13
      "Restaurants"
    elsif business.frugles.first.category_id == 14
      "Department Stores"
    elsif business.frugles.first.category_id == 15
      "Travel & Luggage"
    else
      "Other"
    end
  end
  
  def frugle_details(frugle)
    if frugle.other_offer
  		"Not valid with any other offer." + " "
  	end
  	if frugle.visit
  		"Limit one per visit." + " "
  	end
  	if frugle.altered
  		"Coupon void if altered."  + " "
  	end
  	if frugle.customers == "New"
  		"New customers only." + " "
  	elsif frugle.customers == "Returning"
  		"Returning customers only."  + " "
  	end
    unless frugle.mobile.nil?
  	  "We will accept this Frugle printed out or on a phone."
    else
  	  "We will only accept this Frugle when it is printed out."
    end
  end
  
end
