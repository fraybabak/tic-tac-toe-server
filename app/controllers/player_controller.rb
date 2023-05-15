class PlayerController < ApplicationController
  def index
    @player = Player.all
    render json: @player
  end


  def get_player
    @player = Player.find(params[:id])
    render json: @player
  end

  def body_params
    params.require(:player).permit(:name)
  end

  def create
    @exists = Player.find(name: body_params[:name])
    if @exists.length > 0:
      render json: @exists[0]
      end
    @player = Player.new(body_params)
    @player.user_name = random_username
    if @player.save
      render json: @player
    else
      render json: @player.errors
    end
  end
end
