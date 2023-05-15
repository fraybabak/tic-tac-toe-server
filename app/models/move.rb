class Move < ApplicationRecord
  belongs_to :player, class_name: 'Player'
  belongs_to :game, class_name: 'Game'
  attribute :position, :integer
end
