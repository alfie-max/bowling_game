class API::V1::FramesController < ApplicationController
  before_action :set_game, only: %i[create update]
  before_action :set_frame, only: %i[update]

  # POST /api/v1/games/:game_id/frames
  def create
    render json: @game.frames.create!(frame_params), status: :created
  end

  # PUT /api/v1/games/:game_id/frames/:number
  def update
    @frame.update!(frame_params)
    render json: @frame.reload, status: :ok
  end

  private

  def set_game
    @game ||= Game.find(params[:game_id])
  end

  def set_frame
    @frame ||= @game.frames.find_by!(number: params[:number])
  end

  def frame_params
    params.require(:frame).permit(
      :first_ball_score, :second_ball_score, :third_ball_score
    )
  end
end
