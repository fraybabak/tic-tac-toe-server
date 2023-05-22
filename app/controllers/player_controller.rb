class PlayerController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @players = Player.all # Include wins and losses in the selection
    @players.each do |player|
      player.wins = Game.where(winner_id: player.id, status: "finished").count
      player.losses = Game.where.not(winner_id: player.id)
        .where(status: "finished").where("player_one_id = ? OR player_two_id = ?", player.id, player.id).count
      player.draws = Game.where(status: "draw").where("player_one_id = ? OR player_two_id = ?", player.id, player.id).count
    end
    render json: @players
  end

  def get_player
    @player = Player.find(params[:id])
    render json: @player
  end

  def body_params
    params.require(:player).permit(:name)
  end

  def create
    @exists = Player.where(name: body_params[:name])
    if @exists.exists?
      render json: @exists.first
    else
      @player = Player.new(body_params)
      @player.user_name = random_username
      @player.is_bot = false
      if @player.save
        render json: @player
      else
        render json: @player.errors
      end
    end
  end
end

def random_username
  random_string = "#"
  random_string += (0...5).map { (65 + rand(26)).chr }.join
  random_string
end