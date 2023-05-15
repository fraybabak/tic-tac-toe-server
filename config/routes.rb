Rails.application.routes.draw do
  get '/player', to: 'player#index'
  get '/tic-toc', to: 'tic_toc#index'
end
