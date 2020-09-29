require 'sidekiq/web'

Rails.application.routes.draw do
  get 'home/home'
  
  resources :reminders

  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#home"
end
