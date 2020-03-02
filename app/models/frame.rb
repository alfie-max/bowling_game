class Frame < ApplicationRecord
  belongs_to :game

  before_validation :set_frame_number, on: :create

  validates :frame_number,
            presence: true,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 1 }
  validates :first_ball_score,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 10 }
  validates :second_ball_score,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 10 }
  validates :third_ball_score,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 10 }
  validates :score,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 300 }

  validate :total_frame_score
  validate :third_ball_allowed
  validate :game_over

  after_save :recalculate_score

  def strike?
    first_ball_score.eql?(10)
  end

  def spare?
    !strike? && this_frame_score.eql?(10)
  end

  def first_two_ball_spare?
    (first_ball_score + second_ball_score).eql?(10)
  end

  def last_frame?
    frame_number.eql?(10)
  end

  def this_frame_score
    first_ball_score + second_ball_score + third_ball_score
  end

  def scorecard
    Hash.new.tap do |card|
      card[:frame_number] = frame_number
      card[:score] = score
      card[:first_ball_score] = first_ball_score
      card[:second_ball_score] = second_ball_score
      card[:third_ball_score] = third_ball_score if last_frame?
    end
  end

  private

  def set_frame_number
    self.frame_number = game.frames.count.next
  end

  def total_frame_score
    if !last_frame? && this_frame_score > 10
      errors.add(:base, :invalid_score)
    end
  end

  def third_ball_allowed
    return true if third_ball_score.zero?
    return true if last_frame? && (strike? || first_two_ball_spare?)

    if last_frame? && !(strike? || first_two_ball_spare?)
      errors.add(:third_ball_score, :invalid_play)
    else last_frame?
      errors.add(:third_ball_score, :not_allowed)
    end
  end

  def game_over
    errors.add(:frame_number, :game_over) if frame_number.to_i > 10
  end

  def recalculate_score
    ScoreCalculator.process(game.frames)
  end
end
