class RemoveFromPublications < ActiveRecord::Migration[6.1]
  def change
    remove_reference :publications, :song, index: true, foreign_key: true
    remove_reference :publications, :playlist, index: true, foreign_key: true
  end
end
