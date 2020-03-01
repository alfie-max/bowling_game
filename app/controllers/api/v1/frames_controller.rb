class API::V1::FramesController < ApplicationController
  before_action :set_game, only: %i[create update]
  before_action :set_frame, only: %i[update]

  # POST /api/v1/games/:game_id/frames
  def create
    json_response(@game.frames.create!(frame_params), :created)
  end

  # PUT /api/v1/games/:game_id/frames/:frame_number
  def update
    @frame.update!(frame_params)
    json_response(@frame.reload)
  end

  private

  def set_game
    @game ||= Game.find(params[:game_id])
  end

  def set_frame
    @frame ||= @game.frames.find_by!(frame_number: params[:frame_number])
  end

  def frame_params
    params.require(:frame).permit(
      :first_ball_score, :second_ball_score, :third_ball_score
    )
  end
end
