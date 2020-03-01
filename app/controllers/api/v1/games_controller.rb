class API::V1::GamesController < ApplicationController
  before_action :set_game, only: %i[show update destroy]

  # GET /api/v1/games
  def index
    json_response(Game.all)
  end

  # POST /api/v1/games
  def create
    json_response(Game.create!(game_params), :created)
  end

  # GET /api/v1/games/:id
  def show
    json_response(@game.scoreboard)
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
end
