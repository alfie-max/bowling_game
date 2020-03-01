FactoryBot.define do
  factory :game do
    player_name { Faker::TvShows::Friends.character }
  end
end
