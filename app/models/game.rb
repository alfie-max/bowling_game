class Game < ApplicationRecord
  has_many :frames, -> { order(number: :asc) }

  validates :player_name, presence: true, length: { minimum: 2, maximum: 50 }

  def score
    frames.last&.score || 0
  end
end
