class RenameColumnNumberToFrameNumber < ActiveRecord::Migration[6.0]
  def change
    rename_column :frames, :number, :frame_number
  end
end
