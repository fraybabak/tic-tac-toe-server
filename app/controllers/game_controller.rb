class GameController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

    def list
        @games = Game.all
        render json: @games
    end

    def get_game
        @game = Game.find_by(id:params[:id])
        if @game.nil?
            render json: { error: 'Game not found' }, status: :not_found
            return
        end
        render json: @game
    end


    def create
        player_one = params[:player_one]
        player_two = params[:player_two]
        game_type = params[:game_type]
        @player_one = Player.find_by(id: player_one)
        if @player_one.nil?
            render json: { error: 'Player one not found' }, status: :not_found
            return
        end

        @player_two = Player.find_by(id: player_two)
        if @player_two.nil?
            render json: { error: 'Player two not found' }, status: :not_found
            return
        end
        @game = Game.new(body_params)
        @game.status = :created
        @game.player_one = @player_one
        @game.player_two = @player_two
        if @game.save
            render json: @game, status: :created
        
        else
            render json: { error: @game.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
    end

    private 
    def body_params
        params.require(:game).permit(:player_one, :player_two, :game_type)
    end
end
