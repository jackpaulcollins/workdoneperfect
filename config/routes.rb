# frozen_string_literal: true

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  match "/employee_templates/bulk_upload", to: "employee_templates#bulk_upload", as: :bulk_upload, via: :get
  post "/employee_templates/bulk_upload", to: "employee_templates#process_bulk_upload"

  resources :jobs do
    member do
      get :staff
      post :add_employees
      patch "complete", to: "jobs#complete", as: "complete"
      patch "incomplete", to: "jobs#incomplete", as: "incomplete"
    end
  end

  get "/calendars/get_jobs", to: "calendars#show"
  get "dashboard/daily_data", to: "dashboard#daily_data"
  resources :job_templates
  resources :customers
  resources :employee_attributes
  resources :employees
  resources :employee_templates do
    collection do
      get :form_fields
    end
  end
  resources :company_resources

  draw :turbo

  # Jumpstart views
  if Rails.env.development? || Rails.env.test?
    mount Jumpstart::Engine, at: "/jumpstart"
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # Administrate
  authenticated :user, ->(u) { u.admin? } do
    namespace :admin do
      if defined?(Sidekiq)
        require "sidekiq/web"
        mount Sidekiq::Web => "/sidekiq"
      end

      resources :announcements
      resources :users do
        resource :impersonate, module: :user
      end
      namespace :user do
        resources :connected_accounts
      end
      resources :accounts
      resources :account_users
      resources :plans
      namespace :pay do
        resources :charges
        resources :payment_methods
        resources :subscriptions
      end

      root to: "dashboard#show"
    end
  end

  # API routes
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resource :auth
      resource :me, controller: :me
      resource :password
      resources :accounts
      resources :users
      resources :notification_tokens, only: :create
    end
  end

  # User account
  devise_for :users,
    controllers: {
      omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "users/registrations",
      sessions: "users/sessions"
    }
  devise_scope :user do
    get "session/otp", to: "sessions#otp"
  end

  resources :announcements, only: %i[index show]
  resources :api_tokens
  resources :accounts do
    member do
      patch :switch
    end

    resource :transfer, module: :accounts
    resources :account_users, path: :members
    resources :account_invitations, path: :invitations, module: :accounts
  end
  resources :account_invitations

  # Payments
  resource :billing_address
  namespace :payment_methods do
    resource :stripe, controller: :stripe, only: [:show]
  end
  resources :payment_methods
  namespace :subscriptions do
    resource :billing_address
    namespace :stripe do
      resource :trial, only: [:show]
    end
  end
  resources :subscriptions do
    resource :cancel, module: :subscriptions
    resource :pause, module: :subscriptions
    resource :resume, module: :subscriptions
    resource :upcoming, module: :subscriptions

    collection do
      patch :info
    end

    scope module: :subscriptions do
      resource :stripe, controller: :stripe, only: [:show]
    end
  end
  resources :charges do
    member do
      get :invoice
    end
  end

  resources :agreements, module: :users
  namespace :account do
    resource :password
  end
  resources :notifications, only: %i[index show]
  namespace :users do
    resources :mentions, only: [:index]
  end
  namespace :user, module: :users do
    resource :two_factor, controller: :two_factor do
      get :backup_codes
      get :verify
    end
    resources :connected_accounts
  end

  namespace :action_text do
    resources :embeds, only: [:create], constraints: {id: %r{[^/]+}} do
      collection do
        get :patterns
      end
    end
  end

  scope controller: :static do
    get :about
    get :terms
    get :privacy
    get :pricing
  end

  post :sudo, to: "users/sudo#create"

  match "/404", via: :all, to: "errors#not_found"
  match "/500", via: :all, to: "errors#internal_server_error"

  authenticated :user do
    root to: "dashboard#show", as: :user_root
    # Alternate route to use if logged in users should still see public root
    # get "/dashboard", to: "dashboard#show", as: :user_root
  end

  # Public marketing homepage
  root to: "static#index"
end
