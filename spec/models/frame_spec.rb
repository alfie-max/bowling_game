require 'rails_helper'

RSpec.describe Frame, type: :model do
  subject { create(:frame) }

  it { is_expected.to belong_to(:game) }

  it { is_expected.to validate_presence_of(:frame_number) }
  it { is_expected.to validate_numericality_of(:frame_number).only_integer }
  it { is_expected.to validate_numericality_of(:frame_number).is_greater_than_or_equal_to(1) }

  it { is_expected.to validate_numericality_of(:first_ball_score).only_integer }
  it { is_expected.to validate_numericality_of(:first_ball_score).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:first_ball_score).is_less_than_or_equal_to(10) }

  it { is_expected.to validate_numericality_of(:second_ball_score).only_integer }
  it { is_expected.to validate_numericality_of(:second_ball_score).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:second_ball_score).is_less_than_or_equal_to(10) }

  it { is_expected.to validate_numericality_of(:third_ball_score).only_integer }
  it { is_expected.to validate_numericality_of(:third_ball_score).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:third_ball_score).is_less_than_or_equal_to(10) }

  it { is_expected.to validate_numericality_of(:score).only_integer }
  it { is_expected.to validate_numericality_of(:score).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:score).is_less_than_or_equal_to(300) }

  it { is_expected.to callback(:set_frame_number).before(:validation).on(:create) }

  describe 'frame is invalid if game over' do
    let(:frame) { build :frame, :game_over }

    it 'frame wont be created if game is over' do
      expect(frame).to be_invalid
    end
  end

  describe '#strike?' do
    let(:frame) { build :frame, :strike }
    let(:frame2) { build :frame, :normal }

    it 'returns true for a strike frame' do
      expect(frame.strike?).to be_truthy
    end

    it 'returns false for a normal frame' do
      expect(frame2.strike?).to be_falsey
    end
  end

  describe '#spare?' do
    let(:frame) { build :frame, :spare }
    let(:frame2) { build :frame, :normal }

    it 'returns true for a spare frame' do
      expect(frame.spare?).to be_truthy
    end

    it 'returns false for a normal frame' do
      expect(frame2.spare?).to be_falsey
    end
  end

  describe '#last_frame?' do
    let(:frame) { build :frame, :last_frame }
    let(:frame2) { build :frame, :non_last_frame }

    it 'returns true for the last frame' do
      expect(frame.last_frame?).to be_truthy
    end

    it 'returns false for any other frame' do
      expect(frame2.last_frame?).to be_falsey
    end
  end

  describe '#first_two_ball_spare?' do
    let(:frame) { build :frame, :spare }
    let(:frame2) { build :frame, :normal }

    it 'returns true for frame with first two balls making a spare' do
      expect(frame.first_two_ball_spare?).to be_truthy
    end

    it 'returns false for any other frame' do
      expect(frame2.first_two_ball_spare?).to be_falsey
    end
  end

  describe '#this_frame_score' do
    let(:frame) { build :frame, :normal }
    let(:this_frame_score) { frame.first_ball_score + frame.second_ball_score + frame.third_ball_score }

    it "calculates the frame's score correctly" do
      expect(frame.this_frame_score).to eq(this_frame_score)
    end
  end
end
