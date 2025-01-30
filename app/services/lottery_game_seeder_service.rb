class LotteryGameSeederService
  def self.seed_lotofacil_games
    # Buscando os resultados do arquivo baixado
    results = LotteryCrawler.fetch_lotofacil_results

    puts "Processando dados..."
    puts ""

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

    # Salvando os resultados no banco de dados
    results.each do |result|
      # Garantir que o GameType para "lotofacil" existe
      game_type = GameType.find_by(code: "lotofacil")
      
      if game_type
        # Verificando se o sorteio já foi registrado
        existing_draw = DrawnGame.find_by(
          game_type_id: game_type.id,
          numbers: result[:numbers],
          draw_date: Date.parse(result[:draw_date]),
          draw: result[:draw]
        )

        # Se o sorteio não existir, cria um novo
        unless existing_draw
          puts ""
          puts("Criando novo jogo sorteado, concurso: #{result[:draw]}")
          DrawnGame.create!(
            game_type_id: game_type.id,
            numbers: result[:numbers],
            draw_date: Date.parse(result[:draw_date]),
            draw: result[:draw]
          )
        end

        lottery_game = LotteryGame.find_by(
          game_type_id: game_type.id,
          numbers: result[:numbers]
        )

        if(lottery_game)
          puts ""
          puts("Números da #{game_type.name} já sorteado. Números: #{numbers}")
          lottery_game.update!(has_drawn: true)
        end
      end      
      progress_bar.increment
    end
    progress_bar.finish
  end
end