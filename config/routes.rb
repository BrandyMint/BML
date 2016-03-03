require 'app_constraint'
require 'viewer_constraint'
require 'api_constraint'

Rails.application.routes.draw do
  default_url_options Settings.app.default_url_options.symbolize_keys

  ### API application
  #
  scope subdomain: ApiConstraint::SUBDOMAIN, constraints: ApiConstraint do
    mount API => '/', as: :api
    root controller: :swagger, action: :index, as: :api_doc
  end


  ### Viewer
  #
  scope as: :site, constraints: ViewerConstraint do
    root 'viewer#show'
    get '*any', to: 'viewer#show'
  end


  concern :account do
    ### Account
    # можно было бы объеденить все это в один AccountConstraint но предпочли сделать
    # через Account::BaseController
    #
    scope :account, as: :account, module: :account do
      root to: redirect('/account/landings')
      resources :landings do
        resources :leads
        resources :variants
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

    scope module: :account, as: :account do
      # Editor
      get '/editor/:uuid', to: 'editor#show', as: :landing_editor
      get '/editor/:uuid/*any', to: 'editor#show', as: :landing_editor_any
    end

    resource :account, only: [:edit, :update]
    resources :accounts, only: [:index] do
      member do
        get action: :select, as: :select
      end
    end

    #scope :landing, as: :landing, module: :landing do
      #root controller: :analytics, action: :index
      #resources :landings do
    #ooo
        #resources :collections
        #resource :settings
        #resources :segments
        #resources :clients
      #end
    #end
  end

  concern :authorization do
    # OAuth
    get '/auth/:provider/callback', to: 'omniauth#create'
    get '/auth/failure',            to: 'omniauth#failure'

    get 'login' => 'sessions#new', as: :login
    get 'logout' => 'sessions#destroy', as: :logout
    get 'signup' => 'registration#new', as: :signup
    post 'signup' => 'registration#create'
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :sessions, only: [:create]
  end

  concern :profile do
    resource :profile, controller: :profile, only: [:show, :update] do
      post :send_email_confirmation
    end

    resource :phone_confirmation, only: [:new, :edit, :create, :update]
    get '/email_confirmation' => 'profile#confirm_email'
  end

  resources :leads, only: [:create]

  ## Root application
  #
  scope constraints: AppConstraint do
    root 'welcome#index'

    # Post Leads
    # post 'leads' => 'leads#create', as: :post_lead

    concerns :authorization
    concerns :profile
    concerns :account
  end
end
