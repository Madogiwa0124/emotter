Rails.application.routes.draw do
  get '/post', to: 'posts#show'
  get '/posts', to: 'posts#index'
  get '/posts/new', to: 'posts#new'
end
