class HomeController < ApplicationController
	def index
		@game_types = GameType.all
		@total_mega_sena = LotteryGame.where(game_type_id: GameType.find_by(code: "megasena").id).count

		@total_lotofacil = LotteryGame.where(game_type_id: GameType.find_by(code: "lotofacil").id).count
	end
end
