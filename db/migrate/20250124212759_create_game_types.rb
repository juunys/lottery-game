class CreateGameTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :game_types do |t|
      t.string :name
      t.string :code
      t.integer :max_number
      t.integer :min_number_pick
      t.integer :max_number_pick

      t.timestamps
    end
  end
end
