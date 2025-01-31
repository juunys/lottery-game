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

  desc "Tuplas maior frequência"
  task max_tuples_lotofacil: :environment do
    games = DrawnGame.pluck(:numbers)

    # Criar um hash para armazenar a contagem dos grupos de 5 números
    group_counts = Hash.new(0)

    progress_bar = ProgressBar.create(
      total: games.size,          
      format: '%a [%B] %p%% %t',
      projector: {
        type: 'smoothing',
        strength: 0.2
      },      
      throttle_rate: 0.1,
      progress_mark: '#'
    )

    # Percorrer os números e contar os grupos de 5 números
    games.each do |numbers|
      # Gerar todas as combinações de 5 números
      numbers.combination(5).each do |group|
        sorted_group = group.sort # Ordena para evitar duplicações como [1,2,3,4,5] e [5,4,3,2,1]
        group_counts[sorted_group] += 1
      end
      progress_bar.increment
    end

    # Ordenar os grupos mais frequentes
    top_groups = group_counts.select { |_, count| count > 1 }.sort_by { |_, count| -count }.first(10)

    # Exibir os resultados
    top_groups.each { |group, count| puts "#{group} = #{count} vezes" }
    progress_bar.finish
  end
end
