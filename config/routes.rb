# frozen_string_literal: true

Rails.application.routes.draw do
  root "searches#index"
  resources "searches", only: %i(index show)
  # get 'search/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
