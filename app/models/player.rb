class Player < ApplicationRecord
    attribute :wins  
    attribute :losses
    attribute :draws
    attribute :user_name, :string
    attribute :name, :string
    attribute :is_bot, :boolean
end
