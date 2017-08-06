class Friendship < ApplicationRecord
  belongs_to :user

  validates :friend_a, :friend_b, presence: true
end
