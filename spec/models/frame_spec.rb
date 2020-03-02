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
end
