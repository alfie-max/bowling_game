json.id @game.id
json.player_name @game.player_name
json.score do
  json.total @game.score
  json.frames do
    json.array!(@game.frames) do |frame|
      json.frame_number frame.frame_number
      json.score frame.score
      json.first_ball_score frame.first_ball_score
      json.second_ball_score frame.second_ball_score
      json.third_ball_score frame.third_ball_score if frame.last_frame?
    end
  end
end
