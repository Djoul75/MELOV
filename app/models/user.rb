class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:spotify]

  has_many :received_subscriptions, foreign_key: :following_id,
                                    class_name: "Subscription"

  # has_many :followers, through: :received_subscriptions,
  #                      source: :follower,
  #                      class_name: "User"
  has_many :followings, through: :received_subscriptions,
                       source: :follower,
                       class_name: "User"

  has_many :send_subscriptions, foreign_key: :follower_id,
                                class_name: "Subscription"

  # has_many :followings, through: :send_subscriptions,
  #                       source: :following,
  #                       class_name: "User"
  has_many :followers, through: :send_subscriptions,
                        source: :following,
                        class_name: "User"


  has_many :buddies, dependent: :destroy
  has_many :publications, dependent: :destroy
  has_many :playlists, dependent: :destroy
end
