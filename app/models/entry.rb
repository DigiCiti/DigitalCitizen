class Entry < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
end
