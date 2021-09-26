Rails.application.routes.draw do
  namespace :converts do
    resources :status, only: :index
  end
  resources :converts
end
