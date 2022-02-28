class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :followers, through: :subscriptions
  has_many :followings, through: :subscriptions
  has_many :buddies
  has_many :publications
  has_many :playlists

  validates :first_name, :last_name, :nickname, presence: true
  validates :nickname, uniqueness: true
end
