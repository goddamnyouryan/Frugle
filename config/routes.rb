OmniauthDeviseExample::Application.routes.draw do
  match 'sitemap.xml' => 'sitemaps#sitemap'

  get "saves/new"
  get "saves/destroy"
  get "follows/create"
  get "follows/destroy"
  get "category/create"
  get "category/destroy"
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations", :sessions => 'users/sessions', :passwords => "users/passwords" }
  resources :businesses do
    resources :frugles
  end

  resources :categories do
    resources :subcategories
  end

  match 'about', :to => 'frugles#about'
  match 'terms', :to => 'frugles#terms'
  match 'privacy', :to => 'frugles#privacy'
  match 'contact', :to => 'frugles#contact'
  match 'subcategories_toggle', :to => 'subcategories#toggle'
  match 'map_toggle', :to => 'neighborhoods#map_toggle'
  match 'frugles_toggle', :to => 'frugles#toggle'
  match 'neighborhood_personalizaton', :to => 'neighborhoods#personalization'
  match 'follows_unfollow', :to => 'follows#unfollow'
  match 'categorizations_unfollow', :to => 'categorizations#unfollow'
  match 'verify', :to => "frugles#verify"
  match 'butthole', :to => "neighborhoods#butthole"
  match 'poophole', :to => "neighborhoods#poophole"
  match 'change_neighborhood', :to => "neighborhoods#change"
  match 'out_new_categorization', :to => "categorizations#out_new"
  match 'out_destroy_categorization', :to => "categorizations#out_destroy"
  match 'out_new_subcategorization', :to => "subcategorizations#out_new"
  match 'out_destroy_subcategorization', :to => "subcategorizations#out_destroy"
  match 'select_all_categories', :to => "categorizations#select_all"
  match 'select_none_categories', :to => "categorizations#select_none"
  match 'out_select_all_categories', :to => "categorizations#out_select_all"
  match 'out_select_none_categories', :to => "categorizations#out_select_none"
  match 'select_all_subcategories', :to => "subcategorizations#select_all"
  match 'select_none_subcategories', :to => "subcategorizations#select_none"
  match 'out_select_all_subcategories', :to => "subcategorizations#out_select_all"
  match 'out_select_none_subcategories', :to => "subcategorizations#out_select_none"
  match 'users_admin', :to => "home#users_admin"
  match 'businesses_admin', :to => "home#businesses_admin"
  match 'frugles_admin', :to => "home#frugles_admin"
  match 'remove_user', :to => "home#delete_user"
  match 'remove_business', :to => "home#delete_business"
  match 'remove_frugle', :to => "home#delete_frugle"
  match 'paginate', :to => "frugles#paginate"

  resources :twilio
  resources :subcategories
  resources :frugles do
    member do
      get 'print'
    end
  end
  resources :categorizations
  resources :subcategorizations
  resources :zipcodes
  resources :javascripts
  resources :follows
  resource :saveds
  match '/:id' => "neighborhoods#show"
  resources :neighborhoods
  
  get "home/index"

  #devise_for :users
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
