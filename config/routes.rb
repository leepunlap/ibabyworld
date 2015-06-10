Rails.application.routes.draw do

  root 'application#index'

  get 'pw' => "admin#index"

  # get '*path' => redirect('/?goto=%{path}')

  namespace :api do
    namespace :v1, defaults: {format: 'json'}  do
      resource :sessions do
        member do
          get 'profile', :to => 'sessions#profile', :as => :sessions
          post 'user/authenticate', :to => 'sessions#authenticate_user', :as => :authenticate_user
          post 'user/destroy', :to => 'sessions#destroy', :as => :destroy_user
          post 'authenticate', :to => 'sessions#authenticate', :as => :authenticate
          post 'facebook/auth', :to => 'sessions#facebook_auth', :as => :facebook_auth
          post 'destroy', :to => 'sessions#destroy', :as => :destroy
        end
      end

      resource :members do
        member do
          get '', :to => 'members#list', :as => :members
          post 'create', :to => 'members#create', :as => :create_member
          post 'password/recover', :to => 'members#recover_password', :as => :recover_member_password
          # get 'password/reset', :to => 'members#reset_password', :as => :reset_member_password
          match 'password/reset', :to => 'members#reset_password', :as => :reset_member_password, via: [:get, :post]
          post 'import', :to => 'members#import', :as => :import_member
        end
      end

      resource :articles do
        member do
          get 'get_tag_list', :to => 'articles#get_tag_list', :as => :get_tag_list
          get ':id/medium-images', to: 'articles#get_medium_images'
          get '', :to => 'articles#list', :as => :articles
          get 'all', :to => 'articles#all', :as => :all_articles
          get ':id', :to => 'articles#detail', :as => :article_detail
          post ':id/update', :to => 'articles#update', :as => :update_article
          delete ':id/delete', :to => 'articles#delete', :as => :delete_article
          post 'create', :to => 'articles#create', :as => :create_article
        end
      end

      resource :products do
        member do
          get 'get_tag_list', :to => 'products#get_tag_list', :as => :get_tag_list
          get ':id/medium-images', to: 'products#get_medium_images'
          get '', :to => 'products#list', :as => :products
          get 'all', :to => 'products#all', :as => :all_products
          get ':id', :to => 'products#detail', :as => :product_detail
          post ':id/update', :to => 'products#update', :as => :update_product
          delete ':id/delete', :to => 'products#delete', :as => :delete_product
          post 'create', :to => 'products#create', :as => :create_product
        end
      end

      resource :carts do
        member do
          get 'mycart', :to => 'carts#mycart', :as => :mycart
          get 'additemtocart', :to => 'carts#additemtocart', :as => :additemtocart
          get 'changecartitemqty/:cartitemid/:qty', :to => 'carts#changecartitemqty', :as => :changecartitemqty
          get 'removecartitem', :to => 'carts#removecartitem', :as => :removecartitem
        end
      end

      resources :product_images
      resources :article_images
      resources :pages
      resources :coupons
      resources :banners
      resources :brands
    end
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
