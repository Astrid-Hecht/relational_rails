Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
  root to: 'pages#home'
  get '/items', to: 'items#index'
  get '/items/:id', to: 'items#show'
  get '/artists', to: 'artists#index'
  get '/artists/:id', to: 'artists#show'
  get '/artists/:artist_id/items', to: 'artist_items#index'
  # get '/artists/new', to: 'artists#new'
  # post '/artists', to: 'artists#create'
  # get '/artists/:id/edit', to: 'artists#edit'
  # patch '/artists/:id', to: 'artists#update'
  # delete '/artists/:id', to: 'artists#destroy'
end
