require 'app_constraint'
require 'account_constraint'
require 'site_constraint'

Rails.application.routes.draw do
  scope as: :site, constraints: SiteConstraint do
    root 'landings#show'

    #resources :landings, path: 'lp', only: [:show]
  end

  scope as: :account, path: '_a', module: :account, constraints: AccountConstraint do
    root 'landings#index'

    resources :landings do
      get :editor, action: :edit, controller: 'editor'
      resources :analytics do
        collection do
          get :sources
          get :funnel
          get :abc
          get :users
        end
      end
      resources :collections
      resource :settings
      resources :segments
      resources :landing_versions, path: 'v', controller: 'versions'
      resources :versions
    end
  end

  scope as: :system, subdomain: 'app', constraints: AppConstraint do
    root 'welcome#index'
  end

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
