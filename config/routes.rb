Rails.application.routes.draw do
  root to: 'visitors#index'
  get '/uploads/:file' => 'visitors#show'
  resources :visitors
end
