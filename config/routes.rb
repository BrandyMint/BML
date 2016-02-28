require 'app_constraint'
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

  # API
  scope subdomain: ApiConstraint::SUBDOMAIN, constraints: ApiConstraint do
    mount API => '/', as: :api
    root controller: :swagger, action: :index, as: :api_doc
  end

  scope as: :site, constraints: SiteConstraint do
    root 'landing#show'
    get '*any', to: 'landing#show'
  end

  scope :account, as: :account, module: :account do
    root to: redirect('/account/landings')
    resources :landings do
      resources :leads
      resources :analytics do
        collection do
          get :sources
          get :funnel
          get :abc
          get :users
        end
      end
    end
  end

  resource :account, only: [:edit, :update]

  #scope :landing, as: :landing, module: :landing do
    #root controller: :analytics, action: :index
    #resources :landings do
      #resources :collections
      #resource :settings
      #resources :segments
      #resources :clients
      #resources :landing_versions, path: 'v', controller: 'versions'
      #resources :versions
    #end
  #end

  #end

  scope subdomain: '', constraints: AppConstraint do
    root 'welcome#index'

    resource :profile, controller: :profile, only: [:show, :update] do
      post :send_email_confirmation
    end

    resource :phone_confirmation, only: [:new, :edit, :create, :update]

    resources :accounts, only: [:index, :show]

    # OAuth
    get '/auth/:provider/callback', to: 'omniauth#create'
    get '/auth/failure',            to: 'omniauth#failure'
    concerns :registration

    # Post Leads
    post 'leads' => 'leads#create', as: :post_lead

    # Editor
    get '/editor/:uuid', to: 'editor#show', as: :landing_editor
    get '/editor/:uuid/*any', to: 'editor#show'
  end
end
