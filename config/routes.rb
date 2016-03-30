require 'app_constraint'
require 'viewer_constraint'
require 'sidekiq/web'
require 'sidekiq-status/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
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

      resource :name, controller: :name, only: [:show, :update]
      resource :domains, controller: :domains, only: [:show, :update]
      resource :billing, controller: :billing, only: [:show, :update, :destroy]
      resource :api, controller: :api, only: [:show, :update]

      resources :invites
      resources :members, as: :memberships do
        member do
          post :send_email_confirmation
        end
      end
    end

    scope module: :account, as: :account do
      # Editor
      get '/editor/:uuid', to: 'editor#show', as: :landing_editor
      get '/editor/:uuid/*any', to: 'editor#show', as: :landing_editor_any
    end

    resource :account, only: [:edit]
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
    resource :user, only: [:new, :create]
  end

  concern :profile do
    resource :profile, controller: :profile, only: [:show, :update] do
      post :send_email_confirmation
    end

    resource :phone_confirmation, only: [:new, :edit, :create, :update]
    get '/email_confirmation' => 'profile#confirm_email'
  end

  concern :post_lead do
    resources :leads, only: [:create]
  end

  ### Viewer
  #
  constraints ViewerConstraint.new do
    scope as: :site do
      root 'viewer#show'
      concerns :post_lead

      get '*any', to: 'viewer#show'
    end
  end

  constraints AppConstraint.new do
    ### Admin application
    #
    scope subdomain: 'admin', constraints: { subdomain: 'admin' } do
      Sidekiq::Web.use Rack::Auth::Basic do |username, password|
        username == Secrets.sidekiq.username && password == Secrets.sidekiq.password
      end if Rails.env.production?
      mount Sidekiq::Web, at: '/sidekiq'

      get '/', to: redirect('/admin')
      ActiveAdmin.routes(self)
    end

    ### API application
    #
    scope subdomain: 'api', constraints: { subdomain: 'api' } do
      mount API => '/', as: :api
      root controller: :swagger, action: :index, as: :api_doc
    end

    ### Root application
    #
    scope constraints: { subdomain: '' } do
      root 'welcome#index'
      scope :api do
        mount API => '/', as: :api2
        root controller: :swagger, action: :index, as: :api_doc2
      end

      concerns :post_lead

      concerns :authorization
      concerns :profile
      concerns :account
    end
  end

  get '*anything', to: 'errors#site_not_found'
  get '', to: 'errors#site_not_found'
end
