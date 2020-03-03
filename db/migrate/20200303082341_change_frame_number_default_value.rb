class ChangeFrameNumberDefaultValue < ActiveRecord::Migration[6.0]
  def up
    change_column_default :frames, :frame_number, nil
  end

  def down
    change_column_default :frames, :frame_number, 1
  end
end
