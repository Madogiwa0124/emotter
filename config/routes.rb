Rails.application.routes.draw do
  get '/posts/:id', to: 'posts#show'
  get '/posts', to: 'posts#index'
  get '/posts', to: 'posts#new'
end
