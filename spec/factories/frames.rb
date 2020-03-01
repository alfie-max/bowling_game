FactoryBot.define do
  factory :frame do
    game
    frame_number { 1 }
    first_ball_score { 1 }
    second_ball_score { 1 }
    third_ball_score { 1 }
    score { 1 }
  end
end
