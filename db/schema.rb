# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2025_01_25_022717) do
  create_table "drawn_games", force: :cascade do |t|
    t.integer "game_type_id", null: false
    t.text "numbers"
    t.date "draw_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "draw"
    t.index ["game_type_id"], name: "index_drawn_games_on_game_type_id"
  end

  create_table "game_types", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "max_number"
    t.integer "min_number_pick"
    t.integer "max_number_pick"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lottery_games", force: :cascade do |t|
    t.integer "game_type_id", null: false
    t.string "numbers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_type_id"], name: "index_lottery_games_on_game_type_id"
  end

  add_foreign_key "drawn_games", "game_types"
  add_foreign_key "lottery_games", "game_types"
end
