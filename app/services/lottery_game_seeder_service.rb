class LotteryGameSeederService
  def self.seed_lotofacil_games
    # Buscando os resultados do arquivo baixado
    results = LotteryCrawler.fetch_lotofacil_results

    puts "Processando dados...\n"

    progress_bar = ProgressBar.create(
      total: results.size,          
      format: '%a [%B] %p%% %t',
      projector: {
        type: 'smoothing',
        strength: 0.2
      },      
      throttle_rate: 0.1,
      progress_mark: '#'
    )

    game_type = GameType.find_by(code: "lotofacil")
    return unless game_type

    ActiveRecord::Base.transaction do
      results.each do |result|
        unless DrawnGame.exists?(
          game_type_id: game_type.id,
          numbers: result[:numbers],
          draw_date: Date.parse(result[:draw_date]),
          draw: result[:draw]
        )
          puts "\nCriando novo jogo sorteado, concurso: #{result[:draw]}"
          DrawnGame.create!(
            game_type_id: game_type.id,
            numbers: result[:numbers],
            draw_date: Date.parse(result[:draw_date]),
            draw: result[:draw]
          )
        end

        # Verificar e atualizar o LotteryGame
        lottery_game = LotteryGame.find_by(
          game_type_id: game_type.id,
          numbers: result[:numbers]
        )
      

        if(lottery_game)
          puts("\nNúmeros da #{game_type.name} já sorteado. Números: #{numbers}")
          lottery_game.update!(has_drawn: true)
        end
        progress_bar.increment
      end
    end
    
    progress_bar.finish
  end
end