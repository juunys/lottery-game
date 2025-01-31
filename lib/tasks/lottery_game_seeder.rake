# lib/tasks/lottery_game_seeder.rake
namespace :lottery do
  desc "Seed Lotofacil game results"
  task seed_lotofacil: :environment do
    LotteryGameSeederService.seed_lotofacil_games
  end

  desc "Números que mais sairam"
  task max_drawn_lotofacil: :environment do 
    numbers = DrawnGame.all.pluck(:numbers).join(',').split(',')

    number_counts = numbers.each_with_object(Hash.new(0)) { |number, counts| counts[number] += 1 }

    top_15 = number_counts.sort_by { |_, count| -count }.first(15)

    top_15.each do |number, count|
      puts "Número: #{number} - Ocorrências: #{count}"
    end
  end
end
