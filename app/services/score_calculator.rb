class ScoreCalculator
  attr_reader :frames

  def initialize(frames)
    @frames = frames
  end

  def self.process(*args)
    new(*args).perform
  end

  def perform
    ActiveRecord::Base.transaction do
      frames.each do |frame|
        frame_score =
          if frame.strike?
            strike_score(frame)
          elsif frame.spare?
            spare_score(frame)
          else
            frame.this_frame_score
          end
        previous_frame_score = previous_frame(frame).score

        frame.update_columns(score: frame_score + previous_frame_score)
      end
    end
  end

  def strike_score(frame)
    one_frame_in_future = next_frame(frame)
    two_frames_in_future = next_frame(one_frame_in_future)

    # Last frame score
    return frame.this_frame_score if frame.last_frame?

    # 3 consecutive strikes
    return 30 if one_frame_in_future.strike? && two_frames_in_future.strike?

    # 2 consecutive strikes and a normal score
    if (frame.frame_number != 9) && one_frame_in_future.strike?
      return 20 + two_frames_in_future.first_ball_score
    end

    # normal score and 9th ball strike
    10 + one_frame_in_future.first_ball_score + one_frame_in_future.second_ball_score
  end

  def spare_score(frame)
    one_frame_in_future = next_frame(frame)

    # Last frame score
    return frame.this_frame_score if frame.last_frame?

    # Spare and any kind of a score
    frame.this_frame_score + one_frame_in_future.first_ball_score
  end

  private

  def previous_frame(frame)
    frame_index = frames.index(frame) - 1
    frame_index.negative? ? Frame.new : frames[frame_index]
  end

  def next_frame(frame)
    return Frame.new unless frame.persisted?

    frame_index = frames.index(frame).to_i + 1
    frames[frame_index] || Frame.new
  end
end
