class Game < ApplicationRecord
  has_many :frames, -> { order(frame_number: :asc) }

  validates :player_name, presence: true, length: { minimum: 2, maximum: 50 }

  def score
    frames.last&.score || 0
  end

  def scoreboard
    Hash.new.tap do |board|
      board[:id] = id
      board[:player_name] = player_name
      board[:score] = {
        total: score,
        frames: frames.map(&:scorecard)
      }
    end
  end
end
