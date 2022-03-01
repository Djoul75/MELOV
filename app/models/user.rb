class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:spotify]

  has_many :followers, through: :subscriptions
  has_many :followings, through: :subscriptions
  has_many :buddies
  has_many :publications
  has_many :playlists
end
