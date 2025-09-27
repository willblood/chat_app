Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  mount ActionCable.server => '/cable'
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  post "api/users", to: "users#create"
  post "api/authenticate", to:"sessions#login"
  post "api/chats", to:"chats#create"
  post "api/search/users", to:"users#search"
  post "api/messages", to:"messages#create"
end
