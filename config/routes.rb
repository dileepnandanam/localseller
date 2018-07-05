Rails.application.routes.draw do

  devise_for :users ,controllers: {registrations: "registrations", sessions: "sessions"}
  root to: 'markets#marketplace'

  get 'welcome', to: 'public#welcome'
  match "/auth/:provider/callback" => "auth_callback#callback", :via => [:get, :post]
  namespace :social_auth do
     resources :users 
  end
  match "market" => "markets#marketplace", via: [:get]
  match "search" => "markets#search", via: [:get]
  match "initial_results" => "markets#initial_results", via: [:get]
  match "shops/:permalink" => "shops#show", via: [:get]
  namespace :seller do
    resources :shops do
      get :my_bids, on: :collection
      get :inventory
      get :open_bids
      get :past_purchases
      resource :comments do
        get :search, on: :collection
      end
      resources :products do
        put :image_upload, on: :member 
      end
      resources :purchases do
        put :shipped, on: :member 
      end
    end
    resources :wholesale
  end
  resources :feedbacks
  resources :products do
    get :search, on: :collection
    get :for_shop, on: :collection
    get :wholesale, on: :collection
  end

  resources :shops do
    resources :comments
  end

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
      get :users, on: :member
      post :assign_shop, on: :member
      get :search_user, on: :member
      resources :bills do
        get :payed, on: :member
      end
      resources :products do
        put :image_upload, on: :member
      end
    end
    resource :dashboard do
      get :feedbacks, on: :collection
    end
  end
  devise_scope :user do
    get 'get_location', to: 'sessions#get_location'
    post 'set_location', to: 'sessions#set_location'
  end
  resource :shopper do
    get :shopping_list, on: :member
    get :wholesale, on: :collection
  end

  resources :bids do
    put :accept, on: :member
  end

  resources :subscriptions do
    get :payed
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
