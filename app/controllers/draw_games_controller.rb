class DrawGamesController < ApplicationController
	def index
		@lotofacil_draw_games = DrawnGame.where(game_type_id: GameType.find_by(code: "lotofacil").id).order(draw_date: :desc).page(params[:page]).per(20)
	end

	def seed_lotofacil_games
    	LotteryGameSeederService.seed_lotofacil_games
    	render json: { message: "Jogos sorteados Lotofacil atualizados com sucesso!" }, status: :ok
  		rescue => e
    	render json: { message: "Erro ao atualizar os jogos: #{e.message}" }, status: :unprocessable_entity
  	end
end
