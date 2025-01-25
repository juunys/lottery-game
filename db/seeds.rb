# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

GameType.create(name: "Lotofacil", code: "lotofacil", max_number: 25, min_number_pick: 15, max_number_pick: 20);
GameType.create(name: "Mega Sena", code: "megasena", max_number: 60, min_number_pick: 6, max_number_pick: 20);