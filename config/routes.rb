ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"
  
  map.resource :user_session
  map.resource :account, :controller => "users"

  map.login  'login',  :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  
  map.resources :users do |user|
    user.resources :properties do |property|
      property.resources :images
    end
    user.resources :pages,    :only => [:show, :new, :create, :edit, :update]
    user.resources :contacts, :only => [:create]
  end
  
  map.namespace 'import' do |import|
    
    import.resources :properties, :only => [], :collection => {:api_index => :get, :api_create => :post, :api_create_test => :get}, :member => {:api_show => :get, :api_update => :post, :api_destroy => :post}, :path_prefix => '/import/:guid'
    import.resources :images, :only => [], :collection => {:api_index => :get, :api_create => :post, :api_create_test => :get}, :member => {:api_show => :get, :api_update => :post, :api_destroy => :post}, :path_prefix => '/import/:guid/properties/:property_id'
    import.resources :listing_group_datas, :path_prefix => '/import/:guid'
    
  end
  
  map.namespace 'admin' do |admin|
    
    admin.resources :users

    admin.resources :listing_groups, :active_scaffold => true
    admin.resources :properties,     :active_scaffold => true
    admin.resources :agents,         :active_scaffold => true
    admin.resources :open_homes,     :active_scaffold => true
    admin.resources :page_datas,     :active_scaffold => true

    admin.resources :themes,      :active_scaffold => true
    admin.resources :assets,      :active_scaffold => true
    admin.resources :pages,       :active_scaffold => true
    admin.resources :page_fields, :active_scaffold => true
    
    admin.resources :properties,     :active_scaffold => true
    admin.resources :listing_groups, :active_scaffold => true
    
    admin.resource :data_import, :only => [:create]
    
  end

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
   
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  map.root :controller => 'home', :action => 'index'

end
