class API::V1::GamesController < ApplicationController
  before_action :set_game, only: %i[show update destroy]

  # GET /api/v1/games
  def index
    render json: Game.last(50), status: :ok
  end

  # POST /api/v1/games
  def create
    render json: Game.create!(game_params), status: :created
  end

  # GET /api/v1/games/:id
  def show
    render json: scoreboard, status: :ok
  end

  # PUT /api/v1/games/:id
  def update
    @game.update(game_params)
    head :no_content
  end

  # DELETE /api/v1/games/:id
  def destroy
    @game.destroy
    head :no_content
  end

  private

  def set_game
    @game ||= Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:player_name)
  end

  def scoreboard
    {
      id: @game.id,
      player_name: @game.player_name,
      score: {
        total_score: @game.score
      }
    }
  end
end
