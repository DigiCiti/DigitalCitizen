class Friendship < ApplicationRecord
  belongs_to :user

  validates :friended_user, presence: true
  # validates :user_id != :friended_user
  # validate against duplicate pairings
end
