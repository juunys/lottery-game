class LotteryGame < ApplicationRecord
  belongs_to :game_type

  scope :by_game_type, ->(game_type_id) { where(game_type_id: game_type_id) }
  scope :latest, ->(game_type_id, has_drawn) { 
    query = by_game_type(game_type_id)
    query = query.where(has_drawn: has_drawn)
    query
  }
end
