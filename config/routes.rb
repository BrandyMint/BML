require 'app_constraint'
require 'viewer_constraint'
require 'api_constraint'
require 'sidekiq/web'
require 'sidekiq-status/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  default_url_options Settings.app.default_url_options.symbolize_keys

  scope subdomain: 'admin', constraints: { subdomain: 'admin' } do
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == Secrets.sidekiq.username && password == Secrets.sidekiq.password
    end if Rails.env.production?
    mount Sidekiq::Web, at: "/sidekiq"
  end

  ### API application
  #
  scope subdomain: ApiConstraint::SUBDOMAIN, constraints: ApiConstraint do
    mount API => '/', as: :api
    root controller: :swagger, action: :index, as: :api_doc
  end

  scope :api do
    mount API => '/', as: :api2
    root controller: :swagger, action: :index, as: :api_doc2
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
        resource :settings, only: [:update], controller: 'landing_settings' do
          member do
            get :address
            get :meta
            get :direct
          end
        end
        resources :leads
        resources :viewers
        resources :views
        resources :collections
        resources :variants do
          member do
            patch :activate
            patch :deactivate
          end
        end
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

  get '*anything', to: 'errors#site_not_found'
  get '', to: 'errors#site_not_found'
end
