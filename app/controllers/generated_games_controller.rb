class GeneratedGamesController < ApplicationController
	def index
		@lotofacil = LotteryGame.where(game_type_id: GameType.find_by(code: "lotofacil").id, has_drawn: false)
	end

	def new
	    @game_types = GameType.all
	end

	def create
		game_type = GameType.find(params[:game_type_id])
	    number_of_games = params[:number_of_games].to_i
	    numbers_per_game = params[:numbers_per_game].to_i

	    games = generate_games(game_type, number_of_games, numbers_per_game)

	    # Save the generated games to the database
	    games.each do |numbers|
	      LotteryGame.create!(
	        game_type_id: params[:game_type_id],
	        numbers: numbers
	      )
	    end

	    flash[:notice] = "#{number_of_games} jogo(s) gerado(s) para #{game_type.name}!"
	    redirect_to new_generated_game_path
	end

	def drawned
		@lotofacil_draw_games = LotteryGame.where(game_type_id: GameType.find_by(code: "lotofacil").id, has_drawn: true).page(params[:page]).per(20)
	end

	def show

	end

	private

  	def generate_games(game_type, number_of_games, numbers_per_game)
    	all_numbers = (1..game_type.max_number).to_a

		drawn_numbers = DrawnGame.where(game_type_id: game_type.id).pluck(:numbers)


    	games = []
    	number_of_games.times do
      		loop do
        		game = all_numbers.sample(numbers_per_game).sort
    			unless LotteryGame.exists?(numbers: game, game_type_id: game_type.id) || drawn_numbers.include?(game)
          			games << game
          			break
    			end
      		end
    	end

    	games
  	end
end
