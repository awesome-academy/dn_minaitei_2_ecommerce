# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/home", to: "products#index", as: :root
    devise_for :accounts, controllers: {
      sessions: "accounts/sessions",
      registrations: "accounts/registrations",
      confirmations: "accounts/confirmations"
    }
    resources :products, only: %i(index show) do
      resources :comments
    end
    resource :cart, only: %i(show create destroy update)
    resources :orders, only: %i(create show index) do
      member do
        patch "/cancel", to: "orders#cancel"
      end
    end
    namespace :admin do
      resources :products
      resources :users
      resources :orders
      get "/statistics", to: "statistics#monthly_statistics", as: "monthly_statistics"
      get "/statistics/:month/:year", to: "statistics#monthly_statistics_detail", as: "monthly_statistics_detail"
    end
  end
end
