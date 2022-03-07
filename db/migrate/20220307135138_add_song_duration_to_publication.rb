class AddSongDurationToPublication < ActiveRecord::Migration[6.1]
  def change
    add_column :publications, :song_duration, :integer
  end
end
