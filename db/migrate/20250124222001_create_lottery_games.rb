class CreateLotteryGames < ActiveRecord::Migration[7.0]
  def change
    create_table :lottery_games do |t|
      t.references :game_type, null: false, foreign_key: true
      t.string :numbers

      t.timestamps
    end
  end
end
