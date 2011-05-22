Sitemap::Map.draw do
  
  # default per_page is 50.000 which is the specified maximum.
  # per_page 10

  url root_url, :last_mod => DateTime.now, :change_freq => 'daily', :priority => 1
  
  new_page!
  
  Frugle.all.each do |frugle|
    url frugle_url(frugle), :last_mod => frugle.updated_at, :change_freq => 'weekly', :priority => 0.8
  end

  new_page!
  
  Business.all.each do |business|
    url business_url(business), :last_mod => business.updated_at, :change_freq => 'monthly', :priority => 0.8
  end
                
  # new_page!
  
  # autogenerate  :users,
  #               :last_mod => :updated_at,
  #               :change_freq => lambda { |user| user.very_active? ? 'weekly' : 'monthly' },
  #               :priority => 0.5
  
end