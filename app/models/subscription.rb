class Subscription < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"

  validates :follower, uniqueness: { scope: :following }
  validates :following, uniqueness: { scope: :follower }
end
