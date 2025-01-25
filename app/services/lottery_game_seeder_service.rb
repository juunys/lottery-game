class LotteryGameSeederService
  def self.seed_lotofacil_games
    # Buscando os resultados do arquivo baixado
    results = LotteryCrawler.fetch_lotofacil_results

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
          DrawnGame.create!(
            game_type_id: game_type.id,
            numbers: result[:numbers],
            draw_date: Date.parse(result[:draw_date]),
            draw: result[:draw]
          )
        end
      end
    end
  end
end