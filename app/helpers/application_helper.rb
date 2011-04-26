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
    if frugle.business.category_id == 1
      link_to image_tag('auto.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 2
      link_to image_tag('bodyandbeauty.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 3
      link_to image_tag('cleaning.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 4
      link_to image_tag('entertainment.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 5
      link_to image_tag('family.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 6
      link_to image_tag('financialservices.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 7
      link_to image_tag('food.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 8
      link_to image_tag('health.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 9
      link_to image_tag('home.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 10
      link_to image_tag('nightlife.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 11
      link_to image_tag('partiesandevents.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 12
      link_to image_tag('pets.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 13
      link_to image_tag('professionalservices.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 14
      link_to image_tag('food.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 15
      link_to image_tag('schooling.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 16
      link_to image_tag('shopping.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 17
      link_to image_tag('sports.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    elsif frugle.business.category_id == 18
      link_to image_tag('travel.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    else
      link_to image_tag('auto.png'), business_frugle_path(frugle.business, frugle), :class => 'iframe'
    end
  end
  
end
