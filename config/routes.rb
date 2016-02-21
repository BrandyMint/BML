require 'app_constraint'
require 'account_constraint'
require 'site_constraint'
require 'api_constraint'

Rails.application.routes.draw do
  default_url_options Settings.app.default_url_options.symbolize_keys

  concern :registration do
    get 'login' => 'sessions#new', as: :login
    get 'logout' => 'sessions#destroy', as: :logout
    get 'signup' => 'registration#new', as: :signup
    post 'signup' => 'registration#create'
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :sessions, only: [:create]
    get '/email_confirmation' => 'profile#confirm_email'
  end

  scope subdomain: ApiConstraint::SUBDOMAIN, constraints: ApiConstraint do
    mount API => '/', as: :api
    root controller: :swagger, action: :index, as: :api_doc
  end

  post 'leads' => 'collection_items#create', as: :request
  post 'request' => 'collection_items#create', as: :request

  scope as: :site, constraints: SiteConstraint do
    root 'landings#show'

    #resources :landings, path: 'lp', only: [:show]
  end

  get '/auth/:provider/callback', to: 'omniauth#create'
  get '/auth/failure',            to: 'omniauth#failure'
  concerns :registration

  resource :profile, controller: :profile, only: [:show, :update] do
    post :send_email_confirmation
  end
  resource :phone_confirmation, only: [:new, :edit, :create, :update]

  scope constraints: AccountConstraint do
    root 'landings#index'
  end

  get '/editor/:uuid', to: 'editor#show'
  get '/editor/:uuid/*any', to: 'editor#show'

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
      resources :clients
      resources :landing_versions, path: 'v', controller: 'versions'
      resources :versions
    end
  end

  scope as: :system, subdomain: 'app', constraints: AppConstraint do
    root 'welcome#index'
  end
end
