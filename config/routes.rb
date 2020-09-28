Rails.application.routes.draw do
  get 'home/home'
  
  resources :reminders
  get "fetch_day_options/:picked_day", to: "reminders#fetch_day_options"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#home"
end
