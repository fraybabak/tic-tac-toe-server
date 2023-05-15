Rails.application.routes.draw do
  get '/player/list', to: 'player#index'
  get '/player/get/:id', to: 'player#get_player'
  post '/player/create', to: 'player#create'
  get '/tic-toc', to: 'tic_toc#index'
end
