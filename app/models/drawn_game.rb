class DrawnGame < ApplicationRecord
  belongs_to :game_type

  serialize :numbers, Array
  validates :draw, presence: true, uniqueness: { scope: :game_type_id, message: "This draw already exists for the selected game type." }
  validates :numbers, presence: true
  validates :draw_date, presence: true

  scope :by_game_type, ->(game_type_id) { where(game_type_id: game_type_id) }
  scope :latest, ->(game_type_id) { by_game_type(game_type_id).order(draw_date: :desc).first }

end
