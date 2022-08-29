Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
  root to: 'pages#home'
  get '/items', to: 'items#index'
  get '/artists', to: 'artists#index'
  get '/artists/:id/items', to: 'artist_items#index'
  get '/artists/new', to: 'artists#new'
  post '/artists', to: 'artists#create'
  get '/artists/:id/items/new', to: 'artist_items#new'
  get '/items/:id', to: 'items#show'
  post '/artists/:id/items', to: 'artist_items#create'
  get '/artists/:id', to: 'artists#show'
  # delete '/artists/:id', to: 'artists#destroy'
end
