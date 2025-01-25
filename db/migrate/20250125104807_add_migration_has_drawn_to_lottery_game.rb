class AddMigrationHasDrawnToLotteryGame < ActiveRecord::Migration[7.0]
  def change
    add_column :lottery_games, :has_drawn, :boolean, default: false
  end
end
