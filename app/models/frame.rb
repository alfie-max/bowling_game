class Frame < ApplicationRecord
  belongs_to :game

  before_validation :set_frame_number, on: :create

  validates :number,
            presence: true,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 1,
                            less_than_or_equal_to: 10 }
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

  private

  def set_frame_number
    self.number = game.frames.count.next
  end
end
