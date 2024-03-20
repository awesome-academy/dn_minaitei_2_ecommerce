# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :accounts
  end
end
