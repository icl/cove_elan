require 'resque/server'

CoveElan::Application.routes.draw do

  match '/thumb/:filename.:extension/:offset' => 'thumbs#show'
  resources :meta_data_fields
  resources :meta_data_groups

  devise_for :users

  resources :corpora
  resources :projects
  resources :work_documents
  resources :templates
  resources :user_assets do
    member do
      get "download"
    end
    resources :frames
    
  end
#	resources :documents

  match 'documents/:id/download' => 'documents#download', :as => :download_document
  match 'user_assets/:id/download' => 'user_assets#download', :as => :download_asset
  match 'templates/:id/update_meta_data' => 'templates#update_meta_data'

  match 'templates/:id/duplication' => 'templates#duplication'

  authenticated do
      root :to => 'welcome#index'
      mount Resque::Server.new, :at => "/resque"
  end

  root :to => 'landing#index'
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


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
