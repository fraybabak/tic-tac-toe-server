class MoveController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]
    include MoveHelper

    def list
        @moves = Move.where(game_id: params[:game_id]).order(:created_at)
        render json: @moves
    end

    def get_move
        @move = Move.find_by(id: params[:id])
        if @move.nil?
            render json: { error: 'Move not found' }, status: :not_found
            return
        end
        render json: @move
    end



    def create
        # Check if game exists
        @game = Game.where(id: body_params[:game_id]).where.not(status: 'finished').where.not(status: 'draw').first
        if @game.nil?
            render json: { error: 'Game not found' }, status: :not_found
            return
        end
        if @game.status == 'created'
            @game.status = 'running'
            @game.save
        end

        # Check if player exists
        if ![@game.player_one_id, @game.player_two_id].include? body_params[:player_id]
            render json: { error: 'Player not found' }, status: :not_found
            return
        end

        # Check if move exists
        @exists = Move.where(game_id: body_params[:game_id], position: body_params[:position])
        if @exists.exists?
            render json: { error: 'Move already exists' }, status: :forbidden
            return
        end

        # Check if it's the player's turn
        @last_move = Move.where(game_id: body_params[:game_id]).last
        if @last_move != nil && @last_move.player_id == body_params[:player_id]
            render json: { error: 'Not your turn' }, status: :forbidden
            return
        end

        
        @move = Move.new(player_id: body_params[:player_id], position: body_params[:position], created_at: Time.now, updated_at: Time.now, game_id: body_params[:game_id])

        if @move.save
            render json: {move: @move, stat: check_winner(body_params[:player_id],body_params[:game_id] )}, status: :created
        else
            render json: { error: @move.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
    end

    private

    def body_params
        params.require(:move).permit(:player_id, :game_id, :position,)

        
    end
    def check_winner(player_id, game_id)
      lines = [
        [0,1, 2],
        [3,4, 5],
        [6,7, 8],
        [0,3, 6],
        [1,4, 7],
        [2,5, 8],
        [0,4, 8],
        [2,4, 6]
      ]
    
      moves = Move.where(player_id: player_id, game_id: game_id).pluck(:position)
      if moves.count < 3
        return { game: @game, winner: nil, line: nil}
      end
      @game = Game.find_by(id: game_id)
    
      lines.each do |line|
        is_winner = line if (line - moves).empty?
        if is_winner
          @game.status = :finished
          @game.winner_id = player_id
          @game.save
          return { game: @game, winner: player_id, line: is_winner}
        end
      end

      # Check if there are no more moves
       if Move.where(game_id: game_id).count == 9
            
            @game.status = :draw
            @game.save
            return { game: @game, winner: nil, line: nil}
        end
    
       return { game: @game, winner: nil, line: nil}
    end



end
