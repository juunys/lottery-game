class CreateDrawnGames < ActiveRecord::Migration[7.0]
  def change
    create_table :drawn_games do |t|
      t.references :game_type, null: false, foreign_key: true
      t.text :numbers
      t.date :draw_date

      t.timestamps
    end
  end
end
