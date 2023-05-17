Rails.application.routes.draw do

  # Player routes
  get '/player/list', to: 'player#index'
  get '/player/get/:id', to: 'player#get_player'
  post '/player/create', to: 'player#create'

  # Game routes
  get '/game/list', to: 'game#list'
  get '/game/get/:id', to: 'game#get_game'
  post '/game/create', to: 'game#create'

  # Move routes
  get '/move/list/:game_id', to: 'move#list'
  get '/move/get/:id', to: 'move#get_move'
  post '/move/create', to: 'move#create'
end
