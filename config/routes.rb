AppTrunk02a::Application.routes.draw do
  
  get "report_providents/query"

  get "report_providents/submit"

  get "report_perminum_details/query"

  get "report_perminum_details/submit"

  resources :users
  
  post "sessions/update_password"
  
  get "sessions/unlock"
  
  get "sessions/login"

  get "sessions/logout"

  get "report_emps/query"

  get "report_emps/submit"

  get "cities/cities_tree"
  resources :cities

  post "company_accounts/grid"
  resources :company_accounts

  post "personal_accounts/grid"
  resources :personal_accounts

  post "insure_results_subs/grid"
  resources :insure_results_subs

  get "insure_results/calcs"
  post "insure_results/grid"
  resources :insure_results

  post "employees/grid" , "employees/delete"
  get "employees/insure" , "employees/provident"
  resources :employees

  get "areas/grid"
  resources :areas
  get "cities/grid"
  get "provinces/grid"
  resources :provinces

  resources :tags

  resources :insure_programs

  get "post/grid"

  post "companies/grid" , "companies/delete"
  resources :companies
  
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
   root :to => 'homepages#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   match ':controller(/:action(/:id(.:format)))'
end
