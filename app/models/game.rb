class Game < ApplicationRecord
  enum status: {  created: 1, running: 2, finished: 3, draw: 4 }
  enum game_type: { single_player: 1, two_player: 2}
  belongs_to :player_one, class_name: 'Player'
  belongs_to :player_two, class_name: 'Player'
  belongs_to :winner, class_name: 'Player', optional: true
end
