Rails.application.routes.draw do

  devise_for :users ,controllers: {registrations: "registrations", sessions: "sessions"}
  root to: 'public#index'

  get 'welcome', to: 'public#welcome'
  match "/auth/:provider/callback" => "auth_callback#callback", :via => [:get, :post]
  namespace :social_auth do
     resources :users 
  end
  match "shops/:permalink" => "shops#show", via: [:get]
  namespace :seller do
    resource :shop do
      resources :products
      resources :purchases do
        put :shipped, on: :member 
      end
    end
  end

  resources :products do
    get :search, on: :collection
    get :for_shop, on: :collection
  end

  resources :shops

  resources :shoping_carts do
    get :payed, on: :member
    post :add_to_cart, on: :collection
    get :current_cart, on: :collection
    get :checkout, on: :collection 
    delete :remove_purchase, on: :collection
  end

  namespace :platform do
    resources :shops do
      get :search, on: :collection
      get :purchases, on: :member
      resources :bills do
        get :payed, on: :member
      end
      resources :products
    end
  end
  devise_scope :user do
    get 'get_location', to: 'sessions#get_location'
    post 'set_location', to: 'sessions#set_location'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
