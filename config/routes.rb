Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  get '/login', to: 'sessions#new'
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  resources :users
  resources :posts do
    resources :comments
    resources :likes
  end
  resources :comments do
    resources :replies
  end
end
