class Publication < ApplicationRecord
  belongs_to :user
  belongs_to :playlist
  belongs_to :song
end
