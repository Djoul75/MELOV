class Subscription < ApplicationRecord
  belongs_to :follower, class_name: "User", dependent: :destroy
  belongs_to :following, class_name: "User", dependent: :destroy

  validates :follower, uniqueness: { scope: :following }
  validates :following, uniqueness: { scope: :follower }
end
