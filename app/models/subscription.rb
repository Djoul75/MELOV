class Subscription < ApplicationRecord
  belongs_to :follower
  belongs_to :following

  validates :follower, uniqueness: { scope: :following }
  validates :following, uniqueness: { scope: :follower }
end
