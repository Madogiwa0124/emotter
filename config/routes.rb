Rails.application.routes.draw do
  resources :posts do
    member do
      get :thumbnail
    end
  end
end
