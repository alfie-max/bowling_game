require 'rails_helper'

RSpec.describe Game, type: :model do
  it { is_expected.to have_many(:frames) }

  it { is_expected.to validate_presence_of(:player_name) }
  it { is_expected.to validate_length_of(:player_name).is_at_least(2) }
  it { is_expected.to validate_length_of(:player_name).is_at_most(50) }

  describe '#score' do
    let(:game) { create :game }

    it "calculates the game score when no frames are present" do
      expect(game.score).to eq(0)
    end

    let(:frame) do
      create(
        :frame,
        first_ball_score: 3,
        second_ball_score: 5,
        game: game
      )
    end

    it "calculates the game score with frames" do
      frame.reload
      expect(game.reload.score).to eq(8)
    end
  end
end
