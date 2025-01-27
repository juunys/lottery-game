class LotteryGame < ApplicationRecord
  belongs_to :game_type

  scope :by_game_type, ->(game_type_id) { where(game_type_id: game_type_id) }
end
