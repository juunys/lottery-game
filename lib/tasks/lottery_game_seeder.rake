# lib/tasks/lottery_game_seeder.rake
namespace :lottery do
  desc "Seed Lotofacil game results"
  task seed_lotofacil: :environment do
    LotteryGameSeederService.seed_lotofacil_games
  end
end
