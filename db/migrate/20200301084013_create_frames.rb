class CreateFrames < ActiveRecord::Migration[6.0]
  def change
    create_table :frames do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :number, default: 1
      t.integer :first_ball_score, default: 0
      t.integer :second_ball_score, default: 0
      t.integer :third_ball_score, default: 0
      t.integer :score, default: 0

      t.timestamps
    end
  end
end
