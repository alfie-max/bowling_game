class Game < ApplicationRecord
  validates :player_name, presence: true, length: { minimum: 2, maximum: 50 }
end
