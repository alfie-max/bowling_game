FactoryBot.define do
  factory :frame do
    game
    frame_number { 1 }
    first_ball_score { 0 }
    second_ball_score { 0 }
    third_ball_score { 0 }
    score { 0 }

    trait :non_last_frame do
      frame_number { 4 }
    end

    trait :last_frame do
      frame_number { 10 }
    end

    trait :game_over do
      frame_number { 11 }
    end

    trait :normal do
      first_ball_score { 2 }
      second_ball_score { 7 }
    end

    trait :strike do
      first_ball_score { 10 }
    end

    trait :spare do
      first_ball_score { 6 }
      second_ball_score { 4 }
    end

    trait :ninth_frame_spare do
      frame_number { 9 }
      first_ball_score { 6 }
      second_ball_score { 4 }
    end

    trait :invalid_tenth_frame_play do
      frame_number { 10 }
      first_ball_score { 3 }
      second_ball_score { 2 }
      third_ball_score { 9 }
    end
  end
end
