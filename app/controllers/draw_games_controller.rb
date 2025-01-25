class DrawGamesController < ApplicationController
	def index
		@lotofacil_draw_games = DrawnGame.where(game_type_id: GameType.find_by(code: "lotofacil").id)
	end
end
