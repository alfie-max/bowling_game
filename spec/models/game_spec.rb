require 'rails_helper'

RSpec.describe Game, type: :model do
  it { is_expected.to have_many(:frames) }

  it { is_expected.to validate_presence_of(:player_name) }
  it { is_expected.to validate_length_of(:player_name).is_at_least(2) }
  it { is_expected.to validate_length_of(:player_name).is_at_most(50) }
end
