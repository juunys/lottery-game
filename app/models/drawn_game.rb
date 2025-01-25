class DrawnGame < ApplicationRecord
  belongs_to :game_type

  serialize :numbers, Array
  validates :draw, presence: true
  validates :numbers, presence: true
  validates :draw_date, presence: true
end
