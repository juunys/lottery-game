class AddDrawToDrawnGame < ActiveRecord::Migration[7.0]
  def change
    add_column :drawn_games, :draw, :string
  end
end
